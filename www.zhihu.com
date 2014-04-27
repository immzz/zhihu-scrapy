<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="apple-itunes-app" content="app-id=432274380">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit" />
<meta name="description" content="一个真实的网络问答社区，帮助你寻找答案，分享知识。"/>
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<title>知乎 - 与世界分享你的知识、经验和见解</title>
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(57px).png" />
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(72px).png" sizes="72x72" />
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(76px).png" sizes="76x76" />
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(114px).png" sizes="114x114" />
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(120px).png" sizes="120x120" />
<link rel="apple-touch-icon-precomposed" href="http://static.zhihu.com/static/img/ios/zhihu(152px).png" sizes="152x152" />

<link rel="shortcut icon" href="http://static.zhihu.com/static/favicon.ico" type="image/x-icon" />
<link rel="dns-prefetch" href="p1.zhimg.com"/>
<link rel="dns-prefetch" href="p2.zhimg.com"/>
<link rel="dns-prefetch" href="p3.zhimg.com"/>
<link rel="dns-prefetch" href="p4.zhimg.com"/>
<link rel="dns-prefetch" href="comet.zhihu.com"/>
<link rel="dns-prefetch" href="static.zhihu.com"/>
<link rel="dns-prefetch" href="upload.zhihu.com"/>

<link rel="stylesheet" href="http://static.zhihu.com/static/ver/aaf95f49099e23e877fc6a66eb0b2d28.reg.css" type="text/css" media="screen,print" />

<meta name="google-site-verification" content="FTeR0c8arOPKh8c5DYh_9uu98_zJbaWw53J-Sch9MTg" />
<meta property="qc:admins" content="14414345146201056375" />
<meta name="baidu-site-verification" content="KPFppAFoYF4Kkdv9" />

<link rel="canonical" href="http://www.zhihu.com" />

<meta id="znonce" name="znonce" content="a57dfea9f4794090a3929aa5ca1fbdda">

<script src="http://static.zhihu.com/static/ver/40779259d6cb8446472f5b9f98386159.instant.min.js"></script>

</head>
<body class="zhi">



<div class="wrapper">
<div class="top">
<div class="video-bg">
<div style="max-width: 1500px; margin: 0 auto;z-index:0; text-align: center;">
<video autoplay="autoplay" loop="loop" preload>
<source src="http://s1.zhimg.com/misc/home_video_v3.1.mp4" type="video/mp4" />
<source src="http://s1.zhimg.com/misc/home_video_v3.1.webm" type="video/webm" />
<img src="http://s1.zhimg.com/misc/home-bg.png" style="margin: 0 auto;height:360px; width:1000;">
</video>
</div>
<div class="video-mask"></div>
</div>
<div class="inner-wrapper">
<div class="form-wrapper" id="js-form-wrapper">
<div class="videopopup" data-vid="XNjEwNTk4MjIw">
<div class="logo"></div>
<div class="play-button"></div>
</div>

<div id="js-sign-flow" class="desk-front sign-flow clearfix">
<div class="view view-signin " id="signin">
<form method="post" action="/login" class="zu-side-login-box">
<input type="hidden" name="_xsrf" value="41a0e51ba17f4ef2a9d76bff42d61dcf"/>
<div class="title clearfix">
<a class="js-signup signup-switch with-icon" href="#signup">注册<i class="icon-sign icon-sign-arrow"></i></a>
<a class="with-icon return">
<i class="icon-sign icon-sign-arrow-l"></i><span class="js-title-label">登录知乎</span>
</a>
</div>
<div class="email input-wrapper">
<input required type="email" name="email" placeholder="知乎注册邮箱"

>
</div>
<div class="input-wrapper">
<input required type="password" name="password" maxlength="128" placeholder="密码">
</div>
<div class="captcha-holder">

</div>

<div class="button-wrapper command">
<button class="sign-button" type="submit">登录</button>
</div>
<div class="signin-misc-wrapper clearfix">
<label class="remember-me">
<input type="checkbox" name="rememberme" checked value="y"> 记住我
</label>
<a class="reset-password" target="_blank" href="/resetpassword">忘记密码？</a>
</div>
<div class="weibo-signup-wrapper">
社交帐号直接登录 &nbsp;
<a class="js-bindweibo" href="javascript:;"><i class="icon-sign icon-sign-sina"></i></a>
<a class="js-bindqq" href="javascript:;"><i class="icon-sign icon-sign-qq"></i></a>
</div>
</form>
</div>
<div class="view view-signup selected" id="signup">
<form action="/register/account" method="post" class="zu-side-login-box" id="sign-form-1" autocomplete="off">
<input type="hidden" name="_xsrf" value="41a0e51ba17f4ef2a9d76bff42d61dcf"/>
<div class="title clearfix">
<a class="js-signin signin-switch with-icon" href="#signin">登录<i class="icon-sign icon-sign-arrow"></i></a>
<a class="with-icon return"><i class="icon-sign icon-sign-arrow-l"></i><span class="js-title-label">注册帐号</span></a>
</div>
<div class="name input-wrapper js-weibo-bind-name-transfer">
<input required name="last_name" class="first" placeholder="姓"><input required name="first_name" class="last" placeholder="名">
</div>
<div class="email input-wrapper">
<input required type="email" name="email" placeholder="邮箱">
</div>
<div class="input-wrapper">
<input data-rule-strongpassword="true" required type="password" maxlength="128" name="password" placeholder="密码">
</div>
<div class="captcha-holder"></div>
<div class="button-wrapper command">
<button class="sign-button" type="submit">注册知乎</button>
</div>
<div class="weibo-signup-wrapper">
社交帐号直接登录 &nbsp;
<a class="js-bindweibo" href="javascript:;"><i class="icon-sign icon-sign-sina"></i></a>
<a class="js-bindqq" href="javascript:;"><i class="icon-sign icon-sign-qq"></i></a>
</div>
</form>
</div>
<div class="view view-bindtip">
<span style="font-size: 13px;">
<i class="icon-info"></i>如果你已有知乎帐号，请<a class="js-bindsignin" href="/#signin">登录并绑定</a>
</span>
</div>
<div class="view view-warmup">
<div>
<p>
欢迎你来到知乎。 这是一个能真正体现你价值的地方。<br>
我们相信，娱乐至上的中国互联网，需要一个与众不同的新世界。
</p><p>
在这里，认真、求知、信任与相互尊重，比肤浅的趣味更有意义；<br>
在这里，真正有价值的信息是绝对的稀缺品，远未得到有效的挖掘和利用；<br>
在这里，人与人之间，可以通过言之有物的分享，建立起真诚而友善的关系。
</p><p>
建立这个新世界并不容易，但你会发现，这也不难，只需要你和我们一样：
</p>
<ul>
<li><b>认真</b>、<b>专业</b>：言之有物，不灌水，为自己的话负责</li>
<li><b>友善</b>、<b>互助</b>：感谢每一个用心的回答，同时尊重与你观点不同的人</li>
</ul>
<p>
独一无二的你，总有见解值得分享；世界那么大，也有等待着你的未知。
</p><p>
欢迎你加入我们，一起创造知乎，发现更大的世界。
</p>
</div>
<div class="command">
<a class="sign-button js-gotoinfo">开始</a>
</div>
</div>
<div class="view view-info">
<h2 class="view-info-title">完善基本资料</h2>
<form class="login" method="post" action="/register/account">
<input type="hidden" name="avatar_path">
<div class="avatar-info">
<div>
<a class="avatar-link">
<span class="zm-entry-head-avatar-edit-button">修改头像</span>
<img src="http://p2.zhimg.com/c0/e3/c0e310228_xl.jpg" class="zm-avatar-editor-preview js-avatar" />
</a>
</div>
</div>
<div class="main-info">
<div class="input-wrapper" style="margin: 0 0 18px;">
<input required class="zg-form-text-input text" aria-label="邮箱" name="email" placeholder="邮 箱" spellcheck="false" type="email" value="">
</div>
<div class="zg-form-text-input-group-horizontal gender-wrap clearfix">
<span>
<label><input type="radio" name="gender" value="1" checked class="male"/> 男&nbsp;&nbsp;</label>
<label><input type="radio" name="gender" value="0" class="female"/> 女</label>
</span>
<span>
<div class="business-selection">
<select name="business">
<option value="">选择行业</option>


<option value="高新科技">高新科技</option>

<option value="互联网">&nbsp;&nbsp;&nbsp;互联网</option>

<option value="电子商务">&nbsp;&nbsp;&nbsp;电子商务</option>

<option value="电子游戏">&nbsp;&nbsp;&nbsp;电子游戏</option>

<option value="计算机软件">&nbsp;&nbsp;&nbsp;计算机软件</option>

<option value="计算机硬件">&nbsp;&nbsp;&nbsp;计算机硬件</option>




<option value="信息传媒">信息传媒</option>

<option value="出版业">&nbsp;&nbsp;&nbsp;出版业</option>

<option value="电影录音">&nbsp;&nbsp;&nbsp;电影录音</option>

<option value="广播电视">&nbsp;&nbsp;&nbsp;广播电视</option>

<option value="通信">&nbsp;&nbsp;&nbsp;通信</option>




<option value="金融">金融</option>

<option value="银行">&nbsp;&nbsp;&nbsp;银行</option>

<option value="资本投资">&nbsp;&nbsp;&nbsp;资本投资</option>

<option value="证券投资">&nbsp;&nbsp;&nbsp;证券投资</option>

<option value="保险">&nbsp;&nbsp;&nbsp;保险</option>

<option value="信贷">&nbsp;&nbsp;&nbsp;信贷</option>

<option value="财务">&nbsp;&nbsp;&nbsp;财务</option>

<option value="审计">&nbsp;&nbsp;&nbsp;审计</option>




<option value="服务业">服务业</option>

<option value="法律">&nbsp;&nbsp;&nbsp;法律</option>

<option value="餐饮">&nbsp;&nbsp;&nbsp;餐饮</option>

<option value="酒店">&nbsp;&nbsp;&nbsp;酒店</option>

<option value="旅游">&nbsp;&nbsp;&nbsp;旅游</option>

<option value="广告">&nbsp;&nbsp;&nbsp;广告</option>

<option value="公关">&nbsp;&nbsp;&nbsp;公关</option>

<option value="景观">&nbsp;&nbsp;&nbsp;景观</option>

<option value="咨询分析">&nbsp;&nbsp;&nbsp;咨询分析</option>

<option value="市场推广">&nbsp;&nbsp;&nbsp;市场推广</option>

<option value="人力资源">&nbsp;&nbsp;&nbsp;人力资源</option>

<option value="社工服务">&nbsp;&nbsp;&nbsp;社工服务</option>

<option value="养老服务">&nbsp;&nbsp;&nbsp;养老服务</option>




<option value="教育">教育</option>

<option value="高等教育">&nbsp;&nbsp;&nbsp;高等教育</option>

<option value="基础教育">&nbsp;&nbsp;&nbsp;基础教育</option>

<option value="职业教育">&nbsp;&nbsp;&nbsp;职业教育</option>

<option value="幼儿教育">&nbsp;&nbsp;&nbsp;幼儿教育</option>

<option value="特殊教育">&nbsp;&nbsp;&nbsp;特殊教育</option>

<option value="培训">&nbsp;&nbsp;&nbsp;培训</option>




<option value="医疗服务">医疗服务</option>

<option value="临床医疗">&nbsp;&nbsp;&nbsp;临床医疗</option>

<option value="制药">&nbsp;&nbsp;&nbsp;制药</option>

<option value="保健">&nbsp;&nbsp;&nbsp;保健</option>

<option value="美容">&nbsp;&nbsp;&nbsp;美容</option>

<option value="医疗器材">&nbsp;&nbsp;&nbsp;医疗器材</option>

<option value="生物工程">&nbsp;&nbsp;&nbsp;生物工程</option>

<option value="疗养服务">&nbsp;&nbsp;&nbsp;疗养服务</option>

<option value="护理服务">&nbsp;&nbsp;&nbsp;护理服务</option>




<option value="艺术娱乐">艺术娱乐</option>

<option value="创意艺术">&nbsp;&nbsp;&nbsp;创意艺术</option>

<option value="体育健身">&nbsp;&nbsp;&nbsp;体育健身</option>

<option value="娱乐休闲">&nbsp;&nbsp;&nbsp;娱乐休闲</option>

<option value="图书馆">&nbsp;&nbsp;&nbsp;图书馆</option>

<option value="博物馆">&nbsp;&nbsp;&nbsp;博物馆</option>

<option value="策展">&nbsp;&nbsp;&nbsp;策展</option>

<option value="博彩">&nbsp;&nbsp;&nbsp;博彩</option>




<option value="制造加工">制造加工</option>

<option value="食品饮料业">&nbsp;&nbsp;&nbsp;食品饮料业</option>

<option value="纺织皮革业">&nbsp;&nbsp;&nbsp;纺织皮革业</option>

<option value="服装业">&nbsp;&nbsp;&nbsp;服装业</option>

<option value="烟草业">&nbsp;&nbsp;&nbsp;烟草业</option>

<option value="造纸业">&nbsp;&nbsp;&nbsp;造纸业</option>

<option value="印刷业">&nbsp;&nbsp;&nbsp;印刷业</option>

<option value="化工业">&nbsp;&nbsp;&nbsp;化工业</option>

<option value="汽车">&nbsp;&nbsp;&nbsp;汽车</option>

<option value="家具">&nbsp;&nbsp;&nbsp;家具</option>

<option value="电子电器">&nbsp;&nbsp;&nbsp;电子电器</option>

<option value="机械设备">&nbsp;&nbsp;&nbsp;机械设备</option>

<option value="塑料工业">&nbsp;&nbsp;&nbsp;塑料工业</option>

<option value="金属加工">&nbsp;&nbsp;&nbsp;金属加工</option>

<option value="军火">&nbsp;&nbsp;&nbsp;军火</option>




<option value="地产建筑">地产建筑</option>

<option value="房地产">&nbsp;&nbsp;&nbsp;房地产</option>

<option value="装饰装潢">&nbsp;&nbsp;&nbsp;装饰装潢</option>

<option value="物业服务">&nbsp;&nbsp;&nbsp;物业服务</option>

<option value="特殊建造">&nbsp;&nbsp;&nbsp;特殊建造</option>

<option value="建筑设备">&nbsp;&nbsp;&nbsp;建筑设备</option>




<option value="贸易零售">贸易零售</option>

<option value="零售">&nbsp;&nbsp;&nbsp;零售</option>

<option value="大宗交易">&nbsp;&nbsp;&nbsp;大宗交易</option>

<option value="进出口贸易">&nbsp;&nbsp;&nbsp;进出口贸易</option>




<option value="公共服务">公共服务</option>

<option value="政府">&nbsp;&nbsp;&nbsp;政府</option>

<option value="国防军事">&nbsp;&nbsp;&nbsp;国防军事</option>

<option value="航天">&nbsp;&nbsp;&nbsp;航天</option>

<option value="科研">&nbsp;&nbsp;&nbsp;科研</option>

<option value="给排水">&nbsp;&nbsp;&nbsp;给排水</option>

<option value="水利能源">&nbsp;&nbsp;&nbsp;水利能源</option>

<option value="电力电网">&nbsp;&nbsp;&nbsp;电力电网</option>

<option value="公共管理">&nbsp;&nbsp;&nbsp;公共管理</option>

<option value="环境保护">&nbsp;&nbsp;&nbsp;环境保护</option>

<option value="非盈利组织">&nbsp;&nbsp;&nbsp;非盈利组织</option>




<option value="开采冶金">开采冶金</option>

<option value="煤炭工业">&nbsp;&nbsp;&nbsp;煤炭工业</option>

<option value="石油工业">&nbsp;&nbsp;&nbsp;石油工业</option>

<option value="黑色金属">&nbsp;&nbsp;&nbsp;黑色金属</option>

<option value="有色金属">&nbsp;&nbsp;&nbsp;有色金属</option>

<option value="土砂石开采">&nbsp;&nbsp;&nbsp;土砂石开采</option>

<option value="地热开采">&nbsp;&nbsp;&nbsp;地热开采</option>




<option value="交通仓储">交通仓储</option>

<option value="邮政">&nbsp;&nbsp;&nbsp;邮政</option>

<option value="物流递送">&nbsp;&nbsp;&nbsp;物流递送</option>

<option value="地面运输">&nbsp;&nbsp;&nbsp;地面运输</option>

<option value="铁路运输">&nbsp;&nbsp;&nbsp;铁路运输</option>

<option value="管线运输">&nbsp;&nbsp;&nbsp;管线运输</option>

<option value="航运业">&nbsp;&nbsp;&nbsp;航运业</option>

<option value="民用航空业">&nbsp;&nbsp;&nbsp;民用航空业</option>




<option value="农林牧渔">农林牧渔</option>

<option value="种植业">&nbsp;&nbsp;&nbsp;种植业</option>

<option value="畜牧养殖业">&nbsp;&nbsp;&nbsp;畜牧养殖业</option>

<option value="林业">&nbsp;&nbsp;&nbsp;林业</option>

<option value="渔业">&nbsp;&nbsp;&nbsp;渔业</option>



</select>
</div>
</span>
</div>
<div class="input-wrapper">
<input autocomplete="off" maxlength="40" type="text" name="headline" value="" class="zg-form-text-input" placeholder="个人一句话介绍"/>
</div>
<div class="input-wrapper sns-wrap">
<i class="icon-sign icon-sign-sina" style="margin-right:5px"></i><a class="js-weiboname" href="javascript:;" style="margin-right: 10px;">绑定微博</a>
<i class="icon-sign icon-sign-qq" style="margin:0 5px"></i><a class="js-qqname" href="javascript:;">绑定 QQ</a>
</div>
</div>
<div class="command">
<div class="zg-right actions">
<input class="sign-button" type="submit" value="完成注册">
</div>
</div>
</form>
</div>
<div class="view view-bindsignin">
<div class="description">
<div class="avatar">
<img class="js-avatar" src="http://p2.zhimg.com/c0/e3/c0e310228_xl.jpg">
</div>
<div class="detail">
找到好友 <br>
快速进入知乎
</div>
<div class="avatar">
<img src="http://p2.zhimg.com/85/ad/85ada61ab_xl.jpg">
</div>
</div>
<div class="command">
<form method="post" action="/login" class="">
<input type="hidden" name="with_bind" value="1">
<div class="formbar">
<div class="input-wrapper">
<input required class="zg-form-text-input text" name="email" type="email" placeholder="邮 箱">
</div>
<div class="input-wrapper">
<input required class="zg-form-text-input text" maxlength="128" name="password" type="password" placeholder="密 码">
</div>
</div>
<div class="ctrlbar">
<div class="button-wrapper">
<button type="submit" class="sign-button" value="">登录并绑定</button>
</div>
<div class="ft zg-right actions">
<label class=" remember_me"><input type="checkbox" name="rememberme" checked value="y"> 记住我</label>
<span class="middot">·</span>
<a class="reset" target="_blank" href="/resetpassword">忘记密码？</a>
</div>
<div class="ft bottom-label">
<a href="#" class="link-btn js-backto-info">返回注册</a>
</div>
</div>
</form>
</div>
</div>
<div class="view view-followtopic">
<div class="followtip">
<a class="sign-button js-gotofollowpeople zg-right" href="#">跳过</a>

<h2>有哪些你擅长的领域，可以与我们分享？有哪些你感兴趣的领域，想要探索更多？</h2>

</div>
<div class="topics">
<ul class="clearfix">
</ul>
</div>
<div class="command">
<div class="zg-right actions">
<a class="sign-button js-gotofollowpeople" href="#">跳过</a>
</div>
</div>
</div>
<div class="view view-followpeople">
<div class="followtip">
<label class="zg-right friendsfollowed"><i class="icon-green-check"></i>已自动关注微博好友</label>
<h2>关注你的朋友或任何感兴趣的人，获取他们的最新动态。</h2>
</div>
<div class="people">
<ul class="clearfix">
</ul>
</div>
<div class="command">
<div class="zg-right actions">
<a class="link-btn js-gotofollowtopoic" href="#">上一步</a>

<a class="link-btn js-gotoapp" href="#">下一步</a>

</div>
</div>
</div>

<div class="view view-app">
<h2>把知乎放进口袋，握住一个世界</h2>
<div class="app clearfix">
<div class="download">
<h3>客户端下载</h3>
<div class="button-group" style="opacity: 1;">
<ul class="menu-list">
<li><a target="_blank" href="http://api.zhihu.com/client/download/appstore?utm_source=zhihu_register&utm_medium=appstore_link&utm_campaign=appdownload"><i class="ios sprite"></i>iPhone 版</a>
</li>
<li class="android-menu"><a><i class="android sprite"></i>Android 版</a>
<ul class="dropdown">
<li><a target="_blank" href="http://api.zhihu.com/client/download/play?utm_source=zhihu_register&utm_medium=googleplay_link&utm_campaign=appdownload">Google Play</a></li>
<li><a target="_blank" href="http://api.zhihu.com/client/download/wandoujia?utm_source=zhihu_register&utm_medium=wandoujia&utm_campaign=appdownload">豌豆荚</a></li>
<li><a target="_blank" href="http://api.zhihu.com/client/download/apk?utm_source=zhihu_register&utm_medium=apk_link&utm_campaign=appdownload" class="last">本地下载</a></li>
</ul>
</li>
</ul>
<img class="app-qrcode" src="http://static.zhihu.com/static/img/201304_sign/qrcode.png">
</div>
</div>
<div class="phones">
</div>
</div>
<div class="command">
<div class="zg-right actions">
<a class="link-btn js-gotofollowpeople" href="#">上一步</a>
<a class="sign-button js-startuse" href="#">进入知乎</a>
</div>
</div>
</div>

</div>

<div class="failure" id="summary"><ul></ul></div>


<div class="js-captcha captcha-wrap">
<div class="input-wrapper">
<input id="captcha" name="captcha" placeholder="验证码">
</div>
<p class="input-wrapper captcha clearfix js-refresh-captcha">
<span>看不清？</span> <a href="javascript:;">换一张</a>
<img class="js-captcha-img" />
</p>
</div>

<div class="mobi-front">
<div class="button-wrapper">
<button class="sign-button js-signin" type="submit">登录知乎</button>
</div>

<div class="ft mobile">
<a class="js-bindweibo" href="javascript:;"><i class="icon-sign icon-sign-sina"></i>微博登录</a>
<span class="dot">·</span>
<a class="js-bindqq qq-sign-up" href="javascript:;"><i class="icon-sign icon-sign-qq"></i>QQ 登录</a>
<a class="js-signup" href="#signup">注册<i class="icon-sign icon-sign-arrow"></i></a>
</div>
</div>
</div>
</div>
</div>
<div class="bottom">
<div class="inner-wrapper">
<div class="stories zg-clear">
<div class="reps clearfix">

<a target="_blank" href="/topic/19550453" class="rep current" data-type="topic" data-token="19550453">

<span class="info-card">音乐</span>
<img src="http://p1.zhimg.com/48/12/481297ddc_m.jpg">

</a>

<a target="_blank" href="/people/mj1997" class="rep" data-type="member" data-token="66297d6c8981d941e0f0ae1c37751106">

<span class="info-card">MJ勺子，必见辽阔之地</span>
<img src="http://p3.zhimg.com/fd/23/fd23be9e8_m.jpg">

</a>

<a target="_blank" href="/people/edtall" class="rep" data-type="member" data-token="642e40fd8c4dcac56f20b3863e50d746">

<span class="info-card">孙志超，最外行的投资经理/游戏/微信siskosun</span>
<img src="http://p4.zhimg.com/4f/8b/4f8b454fd_m.jpg">

</a>

<a target="_blank" href="/people/lisongwei" class="rep" data-type="member" data-token="4055a09d55538f79261cb7143f6a09f3">

<span class="info-card">李松蔚，普通的心理学工作者</span>
<img src="http://p1.zhimg.com/7b/01/7b0114ec2_m.jpg">

</a>

<a target="_blank" href="/topic/19551991" class="rep" data-type="topic" data-token="19551991">

<span class="info-card">iOS 应用</span>
<img src="http://p2.zhimg.com/16/81/16816701d_m.jpg">

</a>

<a target="_blank" href="/topic/19556950" class="rep" data-type="topic" data-token="19556950">

<span class="info-card">物理学</span>
<img src="http://p3.zhimg.com/7a/7d/7a7dfc72e_m.jpg">

</a>

<a target="_blank" href="/people/MrToyy" class="rep" data-type="member" data-token="547f818559baffd86f27e61d51c7b972">

<span class="info-card">MrToyy，创业大数据。招才。</span>
<img src="http://p1.zhimg.com/41/b4/41b493a56_m.jpg">

</a>

<a target="_blank" href="/people/sky-86-5" class="rep" data-type="member" data-token="950887fb196b0bb47b1f6a2e8c9ab410">

<span class="info-card">sky，老婆的厨师兼保姆</span>
<img src="http://p1.zhimg.com/97/14/97145be1d_m.jpg">

</a>

<a target="_blank" href="/people/hi-id" class="rep" data-type="member" data-token="55ff9b7864ecd46dd0194ac1411787d8">

<span class="info-card">Hi-iD</span>
<img src="http://p2.zhimg.com/8f/fe/8ffe2ed7d_m.jpg">

</a>

<a target="_blank" href="/topic/19609455" class="rep" data-type="topic" data-token="19609455">

<span class="info-card">金融</span>
<img src="http://p1.zhimg.com/58/f5/58f51517a_m.jpg">

</a>

<a target="_blank" href="/people/squarexx" class="rep" data-type="member" data-token="d2ab142fc925698d366ae8e6c7b48915">

<span class="info-card">Xiao Ronnie，Lifetime Researcher</span>
<img src="http://p4.zhimg.com/d9/27/d927c3aef_m.jpg">

</a>

<a target="_blank" href="/topic/19555457" class="rep" data-type="topic" data-token="19555457">

<span class="info-card">商业</span>
<img src="http://p2.zhimg.com/36/d8/36d8e2e9d_m.jpg">

</a>

<a target="_blank" href="/topic/19575492" class="rep" data-type="topic" data-token="19575492">

<span class="info-card">生物学</span>
<img src="http://p1.zhimg.com/d8/cd/d8cdd10c3_m.jpg">

</a>

<a target="_blank" href="/people/eric-liu" class="rep" data-type="member" data-token="e40204272b22d519b1848517520ce3cb">

<span class="info-card">Eric Liu，旅居日本。ACTC 10.6。平面设计、字体排印、汉语方言语音学爱好者。@macarieso</span>
<img src="http://p1.zhimg.com/d3/f0/d3f01f4fd_m.jpg">

</a>

<a target="_blank" href="/people/zhang-xiao-bei" class="rep" data-type="member" data-token="946100dd40f5cf54c41bdd59ad4f0d87">

<span class="info-card">知乎用户，电影爱好者</span>
<img src="http://p1.zhimg.com/da/8e/da8e974dc_m.jpg">

</a>

</div>




<div class="single-story">
<i class="icon-sign icon-sign-spike"></i>

<div class="single-story-inner topic">
<img class="story-avatar" src="http://p1.zhimg.com/48/12/481297ddc_m.jpg">
<div class="story-title">
<div>
<a class="name" href="/topic/19550453" target="_blank">音乐</a>
</div>
<div>790515 人关注该话题，1000 个精华回答</div>
</div>
<div class="sep"></div>
<div class="story-content">

<div class="story-content-answer">
<span class="vote">10021</span>
<p><a class="question_link" target="_blank" href="/question/21321799/answer/18329036">为什么《董小姐》里一句「爱上一匹野马，可我的家里没有草原」会引起如此强烈的共鸣？</a></p>
</div>

<div class="story-content-answer">
<span class="vote">6165</span>
<p><a class="question_link" target="_blank" href="/question/22953113/answer/23174736">有哪些被埋没的好歌？</a></p>
</div>

<div class="story-content-answer">
<span class="vote">3810</span>
<p><a class="question_link" target="_blank" href="/question/19882239/answer/20241444">陈奕迅被称为「歌神」的原因是什么？</a></p>
</div>

<div class="story-content-answer">
<span class="vote">3170</span>
<p><a class="question_link" target="_blank" href="/question/20878803/answer/16478849">目前在中国，什么样的人会自发性付费下载音乐？</a></p>
</div>

<div class="story-content-answer">
<span class="vote">3038</span>
<p><a class="question_link" target="_blank" href="/question/23436237/answer/24668637">为儿子以后泡妞着想，是让他学吉他好，还是学钢琴好？</a></p>
</div>

</div>
</div>

</div>
</div>
</div>
</div>
<div class="footer">
<div class="links">
<div>
<span>&copy; 2014 知乎</span>
<span class="dot">·</span>
<a target="_blank" href="/read">知乎阅读</a>
<span class="dot">·</span>
<a target="_blank" href="/explore">发现</a>
<span class="dot">·</span>
<a target="_blank" href="/iphone">移动应用</a>
<span class="dot">·</span>
<a target="_blank" href="/jobs">来知乎工作</a>
</div>
<div>
<a href="http://www.miibeian.gov.cn/" target="_blank">京 ICP 备 13052560 号</a>
<span>·</span>
<span>京公网安备 11010802010035 号</span>
</div>
</div>
<a title="下载知乎 iPhone 客户端" target="_blank" class="app-link ios icon-sign icon-sign-ios" href="http://api.zhihu.com/client/download/appstore"></a>

<a title="下载知乎 Android 客户端" target="_blank" class="app-link android icon-sign icon-sign-android goog-play" href="http://api.zhihu.com/client/download/play"></a>

</div>

</div>

<script type="text/json" class="json-inline" data-name="current_user">["","","","-1","",0,0]</script>
<script type="text/json" class="json-inline" data-name="env">["zhihu.com","comet.zhihu.com",false,null]</script>






<script type="text/json" class="json-inline" data-name="ga_vars">{"user_created":0,"now":1398514506000,"abtest_mask":"------------------------------","user_attr":[0,0,0,"-","-"],"user_hash":0}</script>

<script src="http://static.zhihu.com/static/js/lib/youkujsapi.js?1"></script>


<script src="http://static.zhihu.com/static/ver/be1f4e09e99650d8ff09ac81943bc61f.extern_src.min.js"></script>
<script src="http://static.zhihu.com/static/ver/ab7c4b4249929feb9f4bba651814e3c0.app_core.js"></script>
<script src="http://static.zhihu.com/static/ver/4572b3f4b780c76df21ba0b8b8392735.sign.js"></script>

<meta name="entry" content="ZH.entrySignPage">

<input type="hidden" name="_xsrf" value="41a0e51ba17f4ef2a9d76bff42d61dcf"/>
</body>
</html>