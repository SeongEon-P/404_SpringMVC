package org.zerock.api01test.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.zerock.api01test.security.APIUserDetailsService;
import org.zerock.api01test.security.filter.APILoginFilter;
import org.zerock.api01test.security.filter.RefreshTokenFilter;
import org.zerock.api01test.security.filter.TokenCheckFilter;
import org.zerock.api01test.security.handler.APILoginSuccessHandler;
import org.zerock.api01test.util.JWTUtil;

import java.util.Arrays;

@Configuration
@Log4j2
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class CustomSecurityConfig {
  private final APIUserDetailsService apiUserDetailsService;
  private final JWTUtil jwtUtil;

  @Bean
  public PasswordEncoder passwordEncoder(){
    return new BCryptPasswordEncoder();
  }

  @Bean
  public WebSecurityCustomizer webSecurityCustomizer(){
    log.info("---------------web configure-----------------");
    return (web) -> web.ignoring()
            .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
            .requestMatchers("/api/member/join");
  }

  @Bean
  public SecurityFilterChain filterChain (final HttpSecurity http) throws Exception {
    log.info("---------------configure-----------------------");
    AuthenticationManagerBuilder authenticationManagerBuilder = http.getSharedObject(AuthenticationManagerBuilder.class);
    authenticationManagerBuilder
            .userDetailsService(apiUserDetailsService)
            .passwordEncoder(passwordEncoder());
    AuthenticationManager authenticationManager = authenticationManagerBuilder.build();
    http.authenticationManager(authenticationManager);

    APILoginFilter apiLoginFilter = new APILoginFilter("/generateToken");
    apiLoginFilter.setAuthenticationManager(authenticationManager);

    APILoginSuccessHandler successHandler = new APILoginSuccessHandler(jwtUtil);
    apiLoginFilter.setAuthenticationSuccessHandler(successHandler);

    http.addFilterBefore(apiLoginFilter, UsernamePasswordAuthenticationFilter.class);

    http.addFilterBefore(
            tokenCheckFilter(jwtUtil, apiUserDetailsService),
            UsernamePasswordAuthenticationFilter.class
    );
    http.addFilterBefore(new RefreshTokenFilter("/refreshToken",jwtUtil), TokenCheckFilter.class);

    http.csrf().disable();
    http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

    http.cors(httpSecurityCorsConfigurer -> httpSecurityCorsConfigurer.configurationSource(corsConfigurationSource()));

    return http.build();
  }

  private TokenCheckFilter tokenCheckFilter(JWTUtil jwtUtil, APIUserDetailsService apiUserDetailsService){
    return new TokenCheckFilter(apiUserDetailsService,jwtUtil);
  }

  @Bean
  public CorsConfigurationSource corsConfigurationSource(){
    CorsConfiguration configuration = new CorsConfiguration();
    configuration.setAllowedOriginPatterns(Arrays.asList("*"));
    configuration.setAllowedMethods(Arrays.asList("HEAD","GET","POST","PUT","DELETE"));
    configuration.setAllowedHeaders(Arrays.asList("Authorization", "Cache-Control","Content-Type"));
    configuration.setAllowCredentials(true);
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**",configuration);
    return source;
  }
}
