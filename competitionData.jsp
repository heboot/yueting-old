<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/nodeid/nodeid.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: 
 == ============================================================================
 == | Desc: DJ大赛数据模板
 == ============================================================================
*/%>


{

"enterpriseInfo":{
    <cms:userInfo userId="21192803"/>
            "userId":"${uId}",
            "userName":"${userInfo.name}",
            "perDesc":"${userInfo.perDesc}",
            "pictures":"${userInfo.picture}",
            "area":"${userInfo.area}",
            "sname":"${userInfo.sname}",
            "sign":"${userInfo.sign}",
            "sexs":"${userInfo.sex}",
            "age":"${userInfo.age}",
            "school":"${userInfo.school}",
            "address":"${userInfo.address}",

    "name":"CNR大赛",
    "info":"寂寞的守候者，注视从不离开，闻变动，立刻飞身，以迎头致命一击。",
    "sex":"1",
    "picture":"",
    "id":"",
},

"details":{
    "topic":"主题大赛-独坐池塘如虎踞，绿杨树下养精神，春来我不先开口，哪个虫儿敢作声。",
    "rule":"1,aaaaaa\n2,bbbbbbbb\n3,cccccccc\n,4ddddddd\n5,ffffffffffff",
},
    <c:set var="_pageSize" value="100" />
    <c:set var="_pageIndex" value="1" />
    <c:if test="${!empty param.pagesize}" >
        <c:set var="_pageSize" value="${param.pagesize}" />
    </c:if>
    <c:if test="${!empty param.pageindex}">
        <c:set var="_pageIndex" value="${param.pageindex}"/>
    </c:if>
"works":[
       <cms:nodecont var="worksNode" nodeid="10296272" dataobjectid="11" pagesize="${_pageSize}" pageidx="${_pageIndex}"/>
       <c:forEach var="curWeiboCont" items="${worksNode}" varStatus="status">
        <cms:content var="curCont" contid="${curWeiboCont.fields.OMS_ID}"/>
        {
            "name":"${curCont.name}",
            "desc":"${curCont.fields.DESCRIPTION}",
            "param":"objType=20;contentId=${curCont.contId};nodeId=10296272;",
            "fileLength":"${curCont.fields.FILMLENGTH}",
            "img":"${cpath}/publish/image/${curCont.fields.DISPLAYFILELISTS}/${curCont.fields.HW_CID}/display/${curCont.fields.UDID}_${imgContType2}",
            <cms:contvisit contid="${curCont.contId}" ifWrite="0"/>
            "playTimes":"${contvisit}",
            "userId":"${curCont.fields.CREATOR}",
            "blogId":"${curCont.fields.BLOG_ID}",
            <cms:dateUtil date="${curCont.publishTime}"/>
            "pubtime":"${dateStr}",
            
            <cms:commentList contId="${curCont.contId}"  objectType="1" pageIndex ="1" pageSize ="1000"/>
            "commentTimes":"${fn:length(commentList)}",

        },          

       </c:forEach>
],

<cms:nodecont var="worksNodeall" nodeid="10296272" dataobjectid="11" pagesize="500" pageidx="1"/>
"workscount":"${fn:length(worksNodeall)}",

}
