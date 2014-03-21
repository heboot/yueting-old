<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="cms" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: licj <lichengjun@wdit.com.cn>
 == ============================================================================
 == | Desc: 用户信息
 == ============================================================================
*/%>
<%/*
json数据样式
{
    "userId":"",
    "sname":"",
    "sex":"",
    "userName":"",
    "perDesc":"",
    "picture":"",
    "area":"",
    "sign":"",
    "age":"",
    "school":"",
    "address":"",
    "isFocused":"",
}
*/%>
<% 
    String myuserId = session.getAttribute("userId")+"";
    request.setAttribute("myuserId",myuserId);
%>
<cms:isLogin loginMode="${param.filterType}" clientId="${param.clientId}"/>
<c:if test="${empty isLogin}">
    {"code":"1014"}
</c:if>
<c:if test="${!empty isLogin}">
{
    "code":"1010",
    <c:set var="_userId" value="${myuserId}" />
    <c:if test="${!empty param.userId}">
        <c:set var="_userId" value="${param.userId}" />
    </c:if>
    <cms:ifSignUpEvent var="ifSignUp"/>
    "ifSignUp":"${ifSignUp}",
    <c:if test="${!empty _userId}">
        <c:set var="uId" value="${_userId}"/>
        <cms:userInfoNode userId="${_userId}"/>
        <cms:box type="outbox" var="oMicroBlogList" userId="${_userId}" />
        <c:set var="worksCount" value="${boxCount}" />
        <cms:fOrN userId="${_userId}" type="noticer"/>
        <c:set var="noticerCount" value="${count}" />
        <cms:fOrN var="followers" userId="${_userId}" type="follower"/>
        <c:set var="isFocused" value="0" />
        <c:forEach var="oneFollower" items="${followers}">
            <c:if test="${oneFollower.id == myuserId}">
                <c:set var="isFocused" value="1" />
            </c:if>
        </c:forEach>
        <c:set var="followerCount" value="${count}" />
        <cms:userInfo userId="${uId}"/>
        "userId":"${uId}",
        "userName":"${userInfo.name}",
        "perDesc":"${userInfo.perDesc}",
        "picture":"${userInfo.picture}",
        "area":"${userInfo.area}",
        "sname":"${userInfo.sname}",
        "sign":"${userInfo.sign}",
        "sex":"${userInfo.sex}",
        "age":"${userInfo.age}",
        "birthday":"${userInfo.birthday}",
        "school":"${userInfo.school}",
        "address":"${userInfo.address}",
        "LoginUserId":"${myuserId}",
        "nodeId":"${userInfoNode}",
        "worksCount":"${worksCount}",
        "noticerCount":"${noticerCount}",
        "followerCount":"${followerCount}",
        "isFocused":"${isFocused}",
    </c:if>
    <c:if test="${empty _userId}">
        "userId":"0",
        "sname":"",
        "sex":"",
        "userName":"",
        "perDesc":"",
        "picture":"",
        "area":"",
        "sign":"",
        "age":"",
        "school":"",
        "address":"",
        "LoginUserId":"",
        "nodeId":"",
        "worksCount":"",
        "noticerCount":"",
        "followerCount":"",
    </c:if>
}
</c:if>
