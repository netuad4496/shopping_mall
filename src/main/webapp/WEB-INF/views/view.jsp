<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<%--<head>--%>
<%--    <script src="${path}/js/scripts.js?v=<%=System.currentTimeMillis() %>"></script>--%>
<%--</head>--%>

<body>
<!-- Product section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5" style="width:2000px; height: 800px">
        <div class="row gx-4 gx-lg-5 align-items-center" style="margin-top: 50px;">

            <div class="col-md-6" id="slideShow">
                    <ul class="slides" id="imgdiv">
                        <li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"/></li>
                        <li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/099999/fff"/></li>
                    </ul>
                <p class="controller">
                    <span class="prev">&lang;</span>
                    <span class="next">&rang;</span>
                </p>
            </div>

            <div class="col-md-6" style="padding-left: 50px">
                    <div class="small mb-1" style="font-size: medium" id="createdDate"></div>
                    <h1 class="display-1 fw-bolder" id="title"></h1>
                    <div class="fs-1 mb-5">
                        <span id="price"></span>
                    </div>

                    <p class="lead" id="content"></p>
                    <div class="d-flex">
                        <input class="form-control text-center me-3" id="inputQuantity" type="num" value="1"
                               style="max-width: 3rem"/>
                        <button class="btn btn-outline-dark flex-shrink-0" type="button">
                            <i class="bi-cart-fill me-1"></i>
                            Add to cart
                        </button>
                    </div>
            </div>
        </div>
    </div>
</section>

<div class="btn_wrap text-center">
    <button type="button" class="btn btn-secondary" onclick="goList()">????????????</button>
    <c:if test="${role != 'ADMIN'}"><button type="button" class="btn btn-danger" disabled>????????????</button></c:if>

    <c:if test="${role == 'ADMIN'}"><button type="button" class="btn btn-danger" onclick="deleteBoard()">????????????</button></c:if>
    <button type="button" class="btn btn-primary" onclick="goWrite()">????????????</button>
</div>

<!-- chatting start-->
<section class="mb-5" style="margin-top: 30px">
    <div class="card bg-light">
        <div class="card-body">
            <!-- Comment form-->
            <form class="mb-4"><textarea class="form-control" rows="3" placeholder="????????? ??????????????????"></textarea></form>
            <!-- Comment with nested comments-->
            <div class="d-flex mb-4">
                <!-- Parent comment-->
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    If you're going to lead a space frontier, it has to be government; it'll never be private
                    enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified
                    risks.
                    <!-- Child comment 1-->
                    <div class="d-flex mt-4">
                        <div class="flex-shrink-0"><img class="rounded-circle"
                                                        src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
                        </div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            And under those conditions, you cannot establish a capital-market evaluation of that
                            enterprise. You can't get investors.
                        </div>
                    </div>
                    <!-- Child comment 2-->
                    <div class="d-flex mt-4">
                        <div class="flex-shrink-0"><img class="rounded-circle"
                                                        src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
                        </div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            When you put money directly to a problem, it makes a good headline.
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single comment-->
            <div class="d-flex">
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    When I look at the universe and all the ways the universe wants to kill us, I find it hard to
                    reconcile that with statements of beneficence.
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer-->
<footer class="py-5 bg-dark" style="bottom: 0; width: 100%;">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>


</body>

<script type="text/javascript">

    window.onload = () => {
        findBoard();
        findFile();
    }

    // ====================================================================================
    /**
     * ?????? ????????????
     */
    function slides() {
        const slides = document.querySelector(".slides"); //?????? ???????????? ????????????
        let slideImg = document.querySelectorAll('.slides li'); //?????? ???????????????
        let currentIdx = 0; //?????? ???????????? index
        let slideCount = slideImg.length; // ???????????? ??????
        const prev = document.querySelector('.prev'); //?????? ??????
        const next = document.querySelector('.next'); //?????? ??????
        const slideWidth = 300; //????????? ???????????? ??????
        const slideMargin = 50; //?????????????????? margin ???

        //?????? ???????????? ???????????? ?????? ??????
        slides.style.width = (slideWidth + slideMargin) * slideCount + 'px';

        function moveSlide(num) {
            slides.style.left = -num * 710 + 'px';
            currentIdx = num;
        }

        prev.addEventListener('click', function () {
            /*??? ?????? ??????????????? ?????? ????????????
            ?????? ?????? ????????? ????????? ?????? ?????? ?????? ??????
            currentIdx !==0????????? moveSlide ?????? ????????? */

            if (currentIdx !== 0) moveSlide(currentIdx - 1);
        });

        next.addEventListener('click', function () {
            /* ????????? ??????????????? ?????? ????????????
            ?????? ?????? ????????? ????????? ?????? ?????? ?????? ??????
            currentIdx !==slideCount - 1 ?????????
            moveSlide ?????? ????????? */
            if (currentIdx !== slideCount - 1) {
                moveSlide(currentIdx + 1);
            }
        });
    }

    // ====================================================================================

    /**
     * ????????? ??????
     */
    function findBoard() {

        fetch(`/api/boards/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            console.table(data);
            data.createdDate = "????????? : " + moment(data.createdDate).format('YYYY-MM-DD HH:mm:ss');
            data.price = data.price.toLocaleString() + "???";

            Object.keys(data).forEach(key => {
                const elem = document.getElementById(key);
                if (elem) {
                    elem.innerText = data[key];
                }
            });
            slides();
        }).catch(error => {
            alert('????????? ????????? ?????? ??? ????????????.');
            goList();
        });
    }

    // ====================================================================================

    /**
     * ?????? ??????
     */
    function findFile() {

        fetch(`/s3/file/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            console.log(data);
            let html = '';
            if (!data.length) {
                html = `<li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"/></li>`
            } else {
                data.forEach((obj, idx) => {
                    console.log(obj.filePath);
                    html += `<li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="`+ obj.filePath +`"/></li>
                   `;
                });
            }
            document.getElementById('imgdiv').innerHTML = html;
        }).catch(error => {
            alert('?????? ????????? ?????? ??? ????????????.');
            goList();
        });
    }

    // ====================================================================================

    /**
     * ????????????
     */
    function goWrite() {
        location.href = `/shopping/write.do` + location.search +`&id=${id}`;
    }

    /**
     * ????????????
     */
    function deleteBoard() {

        if ( !confirm(`${id}??? ???????????? ????????????????`) ) {
            return false;
        }

        fetch(`/api/boards/${id}`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },

        }).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }

            alert('?????????????????????.');
            goList();

        }).catch(error => {
            alert('????????? ?????????????????????.');
        });
    }

    // ====================================================================================

    /**
     * ????????? ??????
     */
    function goList() {
        location.href = '/shopping/list.do' + location.search;
    }
</script>

</html>