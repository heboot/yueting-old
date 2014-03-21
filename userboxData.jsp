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
 == | Author: licj <lichengjun@wdit.com.cn>
 == ============================================================================
 == | Desc: 我的微博列表
 == ============================================================================
*/%>
<%/*
json数据样式
{
    in:userid,pageindex,pagesize

    "count":"${count}",
    "BlogList":[
        {

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
        <cms:box type="outbox" var="oMicroBlogList" userId="${_userId}" pagesize="${_pageSize}" pageidx="${_pageIndex}"/>
        "count":"${boxCount}",
        "pagesize":"${_pageSize}",
        "blogList":[
        <c:forEach var="blog" items="${oMicroBlogList}" >
            {
                <cms:userInfo userId="${blog.userId}"/>
                "blogStatus":"${blog.blogStatus}",
                "userId":"${blog.userId}",
                "userImg":"${userInfo.picture}",
                "userName":"${userInfo.sname}",
                "mobile":"${userInfo.mobile}",
                "blogId":"${blog.id}",
                "body":"${blog.body}",
                <c:set var="pubTime" scope="request" value="${blog.postTime}"/>
                "pubTime":"<%=DateUtil.getNowTime(request.getAttribute("pubTime")) %>",
                "img":"${blog.imgPath}",
                "title":"${blog.videoTitle}",
                "videoId":"${blog.videoId}",
                "bolgType":"${blog.bolgType}",
                "omsId":"${blog.omsId}",
                <c:if test="${!empty blog.omsId}">
                    <cms:contvisit contid="${blog.omsId}"/>
                    "playTimes":"${contvisit}",
                    <cms:comment contentId="${blog.omsId}" />
                    "commentTimes":"${count}",
                    <cms:content  var="currCont" contid="${blog.omsId}"/>
                    "videoImg":"${cpath}/publish/image/${currCont.fields.DISPLAYFILELISTS}/${currCont.fields.HW_CID}/display/${currCont.fields.UDID}_${imgContType}",
                    "param":"objType=20;contentId=${currCont.contId};nodeId=",
                </c:if>
                <c:if test="${empty blog.omsId}">
                    "playTimes":"0",
                    "commentTimes":"0",
                    "videoImg":"",
                    "param":"",
                </c:if>
                "favTimes":"${blog.favTimes}",
                "replyTimes":"${blog.replyTimes}",
                "transmitTimes":"${blog.transmitTimes}",
                "status":"${blog.status}",
            },
        </c:forEach>
        ],
    </c:if>
    <c:if test="${empty _userId}">
        "count":"0",
        "blogList":[],
    </c:if>
}
