<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/cms.tld" prefix="cms" %>
<%@ include file="/common/taglibs.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: cuiyizhou <cuiyizhou@wdit.com.cn>
 == ============================================================================
 == | Desc: 登录状态与手机号数据
 == ============================================================================
*/%>
<%/*
json数据样式
{
    "phoneNum":"",
}
*/%>
<%
    String userId = session.getAttribute("userId")+"";
    request.setAttribute("userId",userId);
%>
{
    <c:set var="loginMode" value="0" />
    <c:if test="${!empty param.filterType}">
        <c:set var="loginMode" value="${param.filterType}" />
    </c:if>
    <cms:isLogin loginMode="${loginMode}" clientId="${param.clientId}"/>
    "phoneNum":"${isLogin}",
    <c:if test="${!empty userInfo}">
    "userInfo":{
        "userId":"${userId}",
        "picture":"${userInfo.picture}",
        "sname":"${userInfo.sname}",
        "sex":"${userInfo.sex}",
        "address":"${userInfo.address}",
    },
    </c:if>
}