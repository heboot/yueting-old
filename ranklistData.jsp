<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="cms" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%@page import="com.wondertek.mobilevideo.core.util.DateUtil"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: kevin
 == ============================================================================
 == | Desc: 详情页数据模板
 == ============================================================================
*/%>
<%/*
json数据样式
*/%>

<% 
    String myuserId = session.getAttribute("userId")+"";
    request.setAttribute("myuserId",myuserId);
%>
{
    <cms:isLogin loginMode="${param.filterType}" clientId="${param.clientId}" />
    <c:if test="${empty isLogin}">
        "code":"1014",
    </c:if>
    <c:if test="${!empty isLogin}">
        "code":"1010",
    </c:if>

    <c:set var="pagesize" value="20" />
    <c:set var="pageidx" value="1" />
    <c:if test="${!empty param.pagesize}" >
        <c:set var="pagesize" value="${param.pagesize}" />
    </c:if>
    <c:if test="${!empty param.pageidx}" >
        <c:set var="pageidx" value="${param.pageidx}" />
    </c:if>


    <c:if test="${param.type == 'work'}" >
    "worksList":[
    <c:set var="blogids" value="${fn:split(param.data,';')}"/>
    <cms:sortVoteTimes var="works" pagesize="${pagesize}" pageidx="${pageidx}" type="1"/>
    <c:forEach var="blogid" items="${works}">
    {
        <cms:detailBlog microBlogId="${blogid}" />
        "userId":"${microBlog.userId}",
        "id":"${microBlog.id}",
        "body":"${microBlog.body}",
        <c:set var="pubTime" scope="request" value="${microBlog.postTime}"/>
        "pubTime":"<%=DateUtil.getNowTime(request.getAttribute("pubTime")) %>",
        "img":"${microBlog.imgPath}",
        "title":"${microBlog.videoTitle}",
        "videoId":"${microBlog.videoId}",
        "blogType":"${microBlog.bolgType}",
        "blogId":"${blogid}",
        <c:if test="${!empty microBlog.omsId}">
            <cms:contvisit contid="${microBlog.omsId}" />
            "playTimes":"${contvisit}",
            <cms:comment contentId="${microBlog.omsId}" />
            "commentTimes":"${count}",
            <cms:content  var="currCont" contid="${microBlog.omsId}" />
            "videoImg":"${cpath}/publish/image/${currCont.fields.DISPLAYFILELISTS}/${currCont.fields.HW_CID}/display/${currCont.fields.UDID}_${imgContType2}",
            "param":"objType=20;contentId=${currCont.contId};nodeId=${currCont.fields.NODEID};",
        </c:if>
        <c:if test="${empty microBlog.omsId}">
            "playTimes":"0",
            "commentTimes":"0",
            "videoImg":"",
            "param":"",
        </c:if>
        "favTimes":"${microBlog.favTimes}",
        "replyTimes":"${microBlog.replyTimes}",
        "transmitTimes":"${microBlog.transmitTimes}",
    },
    </c:forEach>
    ],
    </c:if>

    <c:if test="${param.type == 'user'}" >
    "userInfoList":[
    <c:set var="ids" value="${fn:split(param.data,';')}"/>
    <cms:sortVoteTimes var="users" pagesize="${pagesize}" pageidx="pageidx" type="0"/>
    <c:forEach var="id" items="${users}" >
    {
        <cms:fOrN var="followers" userId="${id}" type="follower"/>
        <c:set var="isFocused" value="0" />
        <c:forEach var="oneFollower" items="${followers}">
            <c:if test="${oneFollower.id == myuserId}">
                <c:set var="isFocused" value="1" />
            </c:if>
        </c:forEach>
        <cms:userInfo userId="${id}"/>
        "userId":"${id}",
        "userName":"${userInfo.name}",
        "perDesc":"${userInfo.perDesc}",
        <c:if test="${empty userInfo.picture}">
        "picture":"",
        </c:if>
        <c:if test="${!empty userInfo.picture}">
        "picture":"${cpath}/publish/clt${userInfo.picture}",
        </c:if>
        "sname":"${userInfo.sname}",
        "sign":"${userInfo.sign}",
        "sex":"${userInfo.sex}",
        "age":"${userInfo.age}",
        "birthday":"${userInfo.birthday}",
        "LoginUserId":"${myuserId}",
        "isFocused":"${isFocused}",
    },
    </c:forEach>
    ],
    </c:if>
}
