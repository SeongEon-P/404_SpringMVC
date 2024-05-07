async function get1(bno){
    const result = await axios.get(`/replies/list/${bno}`)
    // console.log(result)
    return result.data
}

async function getList({bno, page, size, goLast}){
    const result = await axios.get(`/replies/list/${bno}`, {params: {page,size}})
    console.log(bno, page, size, goLast)
    if(goLast){
        //총 데이터 갯수를 변수에 저장
        const total = result.data.total

        //(총 데이터 수/한 페이지의 사이즈)의 정수 변환값 저장
        const lastPage = parseInt(Math.ceil(total/size))

        //getList 자기 자신을 다시 한 번 실행
        return getList({bno:bno, page:lastPage, size:size})
    }
    return result.data
}
//댓글 추가 함수(댓글 객체 가져오는 함수)
async function addReply(replyObj){
    const response = await axios.post(`/replies/`, replyObj)
    return response.data
}

async function getReply(rno){
    const response = await axios.get(`/replies/${rno}`)
    return response.data
}
async function modifyReply(replyObj){
    const response = await axios.put(`/replies/${replyObj.rno}`, replyObj)
    return response.data
}