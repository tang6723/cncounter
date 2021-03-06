<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../basePath.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>CNC短网址 - CN计数-cncounter</title>
    <jsp:include page="/common/cssjs.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/header.jsp"></jsp:include>
<div class="container-fluid">
    <div class="content_left">
        <p class="h1">CNC短网址生成</p>
        <div>
            <form id="input_form" action="<%=basePath %>tools/shorturl/generate.json" method="post">
                <span>请输入需要转换的URL地址:</span>
                <br/>
                <textarea tabindex="3" id="origurl" name="origurl" rows="4" cols="36"></textarea>
                <br/>
            </form>
            <div style=" margin-top: 10px; ">
                <button tabindex="4" id="btn_generate_link"
                        type="button" class="btn btn-primary"> 生成短链接 </button>
            </div>
        </div>
        <div>
            <br/>
        </div>
        <div class="qrcode-jpeg-area">
            <div>
                <h3>使用说明</h3>
                <ol>
                    <li>输入需要转换的URL</li>
                    <li>点击“生成短链接”按钮</li>
                    <li>等待服务器响应,点击短网址后面的链接</li>
                </ol>
            </div>
            <span>短网址:</span>
            <a id="short_url_anchor" target="_blank">
            </a>
        </div>
    </div>
    <jsp:include page="/common/sidebar.jsp"></jsp:include>
</div>
<jsp:include page="/common/footer.jsp"></jsp:include>

<script type="text/javascript">
    // 此处JS应该归拢收集
    $(function(){
        //
        var $btn_generate_link = $("#btn_generate_link");
        var $short_url_anchor = $("#short_url_anchor");
        var $input_form = $("#input_form");
        var $origurl = $("#origurl");
        //
        $btn_generate_link.bind("click", function(e){
            //
            var origurl = $origurl.val();
            if(!origurl){
                layer.msg("url不能为空!");
                return;
            }
            //
            var url = $input_form.attr("action");
            var data = {
                origurl : origurl
            };

            var successCallback = function (message) {
                var meta = message["meta"] || "";
                var info = message["info"] || "";
                layer.msg(info);
                //
                var shorturl = meta["shorturl"];
                $short_url_anchor.attr("href", shorturl);
                $short_url_anchor.text(shorturl);
            };
            //
            var errorCallback = function (jqXHR, textStatus, errorThrown) {
                // 把错误吃了
                layer.msg("网络请求失败");
            };
            //
            postAjax(url, data, successCallback,errorCallback,1);
            //
        });
    });
</script>
</body>
</html>