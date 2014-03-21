<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: cuiyizhou <cuiyizhou@wondertek.com.cn>
 == ============================================================================
 == | Desc: 场景更新时间
 == ============================================================================
*/%>
<%/*
json数据样式
{
    home-----9bcd632b50d8aaecc704e0246dc56166             "/publish/clt/resource/mobilevideo34/home/home.jsp", -- 首页
    detail-----70a94cc3c8d86e65a81a196dd2ae0dd2           "/publish/clt/resource/mobilevideo34/detail/detail.jsp", -- 详情页
    detail_h-----d5ae3f13cce6703317b88ccd37093363         "/publish/clt/resource/mobilevideo34/detail/detail_h.jsp", -- 详情页-横图
    detailcache-----cf4f8f01729141d13013985fa2e6a352      "/publish/clt/resource/mobilevideo34/detail/detailcache.jsp", -- 详情页
    livelist-----92120f53750fe209ff12125cfb47c0ad         "/publish/clt/resource/mobilevideo34/livelist/livelist.jsp", -- 直播详情页
    player-----20b72e9b14901884c323d21b9d3a590b           "/publish/clt/resource/mobilevideo34/player/player.jsp", -- 播放页
    channel-----d57c7b62a07625aa93dc16195084ab5f          "/publish/clt/resource/mobilevideo34/channel/channel.jsp", --频道
    catalogue-----af35343ee258cc97119478dee9777860        "/publish/clt/resource/mobilevideo34/catalogue/catalogue.jsp", --频道列表
    myorder-----323d326d603cad6a0dbb5824498b06cf          "/publish/clt/resource/mobilevideo34/myorder/myorder.jsp", --订购管理页
    download-----9deb2e100ced1f4613f643c1ca0ead8b         "/publish/clt/resource/mobilevideo34/download/download.jsp", --缓存管理
    help-----0c61e200b2eb94186095266f9e582a37             "/publish/clt/resource/mobilevideo34/help/help.jsp", --帮助
    syssetting-----8074d3edfc07a41f5c51e1ef9e4ed7dd       "/publish/clt/resource/mobilevideo34/setting/syssetting.jsp", --系统设置
    search-----952bb19a39ba5a8c64493944b1451c4a           "/publish/clt/resource/mobilevideo34/search/search.jsp",     --搜索
    vbest-----43a86b28eefbe0215f02d8527bf39834            "/publish/clt/resource/mobilevideo34/vbest/vbest.jsp",
    myspace-----df17535736d816191e7e9ff6bcf19cfb          "/publish/clt/resource/mobilevideo34/myspace/myspace.jsp", --我的空间
    appstore-----7050d8ef896600676c09aa0f4d96e766         "/publish/clt/resource/mobilevideo34/appstore/appstore.jsp", --应用列表
    message-----894bdd33960bbfe7c7e83cebf650d597          "/publish/clt/resource/mobilevideo34/message/message.jsp", --推送消息列表
    booking-----8dd0c2b133570844bb4487e4b259289d          "/publish/clt/resource/mobilevideo34/booking/booking.jsp", --预约管理
    history-----1b10c856f20e8a1e5ee87ed4c9ed8956          "/publish/clt/resource/mobilevideo34/history/history.jsp", --最近观看
    community-----5854a72d0681c9e1817a7accaf228693        "/publish/clt/resource/mobilevideo34/community/community.jsp", --社区首页
    communityList-----ead365be3774d6d68223364d0076cdb2    "/publish/clt/resource/mobilevideo34/community/communityList.jsp", --社区列表页
    communityDetail-----0739685313060dad479fad9feda07f16  "/publish/clt/resource/mobilevideo34/community/communityDetail.jsp", --社区详情页
    videoUpload-----d2494e726d3561cf8cb666d3a8e89327      "/publish/clt/resource/mobilevideo34/videoUpload/videoUpload.jsp", --视频上传
    setting-----e111eed23b61edcbe6f3240f9ebaf854          "/publish/clt/resource/mobilevideo34/setting/setting.jsp", --个人设置页面
    localVideo-----ebd4e9c6f41362f4b551f1961104f847       "/publish/clt/resource/mobilevideo34/localVideo/localVideo.jsp", --本地视频页面
    favorite-----dc16769f7cc1b81b1174a2b6ef755c79         "/publish/clt/resource/mobilevideo34/favorite/favorite.jsp",
    taSpace-----36e06f4d6cfce0890a3e77906370c301          "/publish/clt/resource/mobilevideo34/myspace/taSpace.jsp",
    taDetail-----361778dda57eded3709a6782896aedd5         "/publish/clt/resource/mobilevideo34/myspace/taDetail.jsp",
    sdcfg-----7f0c4139a9f73ec4a1a2889e83f04177            "/publish/clt/resource/mobilevideo34/common/sdcfg.jsp", --sd卡路径配置模板
    tipfile-----0033564b59181b4b40a007eab3f840e4          "/publish/clt/resource/mobilevideo34/common/tipfile.jsp",  --tips提示语数据页
}
*/%>
<cms:lastModified var="lastModifiedCommon" path="/resource/mobilevideo34/common/common.wdml"/>
<c:set var="sceneString" value="/resource/mobileaudio3/home/home,7b6a43109951482bd484f9f873d188e3"/>
<c:set var="sceneSets" value="${fn:split(sceneString, ';')}"/>
{
<c:forEach var="sceneSet" items="${sceneSets}">
    <c:set var="sceneparam" value="${fn:split(sceneSet, ',')}"/>
    <c:set var="lua" value="${sceneparam[0]}.wdml" />
    <c:set var="jsp" value="${sceneparam[0]}.jsp" />
    <cms:lastModified var="lastModifiedLua" path="${lua}"/>
    <cms:lastModified var="lastModifiedJsp" path="${jsp}"/>
    <c:set var="lastModifiedDate" value="${lastModifiedLua}" />
    <c:if test="${lastModifiedLua < lastModifiedJsp}">
        <c:set var="lastModifiedDate" value="${lastModifiedJsp}" />
    </c:if><c:if test="${lastModifiedDate < lastModifiedCommon}">
        <c:set var="lastModifiedDate" value="${lastModifiedCommon}" />
    </c:if>"${sceneparam[1]}":"${lastModifiedDate}",
</c:forEach>
<cms:lastModified path="/resource/mobilevideo34/common/sdcfg.jsp"/>
"3f006e612c12ffb5ccb319730a5eb041":"${lastModified}",
<cms:lastModified path="/resource/mobilevideo34/common/tipfile.jsp"/>
"76d604aeb368a7f967bd0f40ba8fc1ee":"${lastModified}",
}