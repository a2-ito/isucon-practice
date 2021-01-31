<#-- @ftlvariable name="msg" type="java.lang.String" -->
<#-- @ftlvariable name="login" type="java.lang.String" -->
<#-- @ftlvariable name="password" type="java.lang.String" -->

<#include "include/header.html.ftl">

<div id="be-careful-phising" class="panel panel-danger">
    <div class="panel-heading">
        <span class="hikaru-mozi">偽画面にご注意ください！</span>
    </div>
    <div class="panel-body">
        <p>偽のログイン画面を表示しお客様の情報を盗み取ろうとする犯罪が多発しています。</p>

        <p>ログイン直後にダウンロード中や、見知らぬウィンドウが開いた場合、<br/>すでにウィルスに感染している場合がございます。即座に取引を中止してください。</p>

        <p>また、残高照会のみなど、必要のない場面で乱数表の入力を求められても、<br/>絶対に入力しないでください。</p>
    </div>
</div>

<div class="page-header">
    <h1>ログイン</h1>
</div>


<#if msg??>
<div id="notice-message" class="alert alert-danger" role="alert">${msg}</div>
</#if>

<div class="container">
    <form class="form-horizontal" role="form" action="/login" method="POST">
        <div class="form-group">
            <label for="input-username" class="col-sm-3 control-label">お客様ご契約ID</label>

            <div class="col-sm-9">
                <input id="input-username" type="text" class="form-control" placeholder="半角英数字" name="login"
                       value="${login!}"/>
            </div>
        </div>
        <div class="form-group">
            <label for="input-password" class="col-sm-3 control-label">パスワード</label>

            <div class="col-sm-9">
                <input type="password" class="form-control" id="input-password" name="password"
                       placeholder="半角英数字・記号（２文字以上）" value="${password!}"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9">
                <button type="submit" class="btn btn-primary btn-lg btn-block">ログイン</button>
            </div>
        </div>
    </form>
</div>

<#include "include/footer.html.ftl">
