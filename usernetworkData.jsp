<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="cms" %>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: licj <lichengjun@wdit.com.cn>
 == ============================================================================
 == | Desc: 关注与粉丝列表
 == ============================================================================
*/%>
<%/*
json数据样式
{
    in:usertype(follower\noticer),pageindex,pagesize
    '?usertype=noticer&pageIdx='..pageidx_F..'&pageSize='..pagesize_NF..'&userId='..myUserId

    "count":"${count}",
    "userInfoList":[
        {
            "img":"",
            "name:"",
            "id":"",
            "videoTitle":"",
            "sign":"",
        },
    ],
}
*/%>
<%
    String myuserId = session.getAttribute("userId")+"";
    request.setAttribute("myuserId",myuserId);
%>
{
    <c:set var="_pageSize" value="30" />
    <c:if test="${!empty param.pageSize}">
        <c:set var="_pageSize" value="${param.pageSize}" />
    </c:if>
    <c:set var="_pageIndex" value="1" />
    <c:if test="${!empty param.pageIdx}">
        <c:set var="_pageIndex" value="${param.pageIdx}" />
    </c:if>
    <c:set var="_userId" value="${myuserId}" />
    <c:if test="${!empty param.userId}">
        <c:set var="_userId" value="${param.userId}" />
    </c:if>

    <c:if test="${!empty _userId}">
        <c:set var="uId" value="${_userId}"/>
        <cms:fOrN  userId="${uId}" type="${param.usertype}"  pagesize="${_pageSize}" pageidx="${_pageIndex}"/>
        "count":"${count}",
        "myuserId":"${myuserId}",
        "userInfoList":[
            <c:if test="${param.usertype == 'follower'}">
                <c:set var="userList" value="${followers}"/>
            </c:if>
            <c:if test="${param.usertype == 'noticer'}">
                <c:set var="userList" value="${noticers}"/>
            </c:if>
            <c:forEach var="oneUser" items="${followers}">
            {
                "name":"${oneUser.sname}",
                "img":"${oneUser.picture}",
                "sign":"${oneUser.sign}",
                "id":"${oneUser.id}",

                <c:set var="isFocused" value="0" />
                <cms:fOrN userId="${oneUser.id}" type="follower" />
                <c:forEach var="oneFollower" items="${followers}">
                    <c:if test="${oneFollower.id==myuserId}">
                        <c:set var="isFocused" value="1" />
                    </c:if>
                </c:forEach>
                "isFocused":"${isFocused}",
                "myUserId":"${myuserId}",
            },
            </c:forEach>
            <c:forEach var="oneUser" items="${noticers}">
            {
                "name":"${oneUser.sname}",
                "img":"${oneUser.picture}",
                "sign":"${oneUser.sign}",
                "id":"${oneUser.id}",

                <c:set var="isFocused" value="0" />
                <cms:fOrN userId="${oneUser.id}" type="follower" />
                <c:forEach var="oneFollower" items="${followers}">
                    <c:if test="${oneFollower.id==myuserId}">
                        <c:set var="isFocused" value="1" />
                    </c:if>
                </c:forEach>
                "isFocused":"${isFocused}",
                "myUserId":"${myuserId}",
            },
            </c:forEach>
        ],
    </c:if>
    <c:if test="${empty _userId}">
        "count":"0",
        "userInfoList":[],
    </c:if>
}
