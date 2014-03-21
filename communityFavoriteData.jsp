<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2011, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: liuchaobing <liuchaobing@mantis.com>
 == ============================================================================
 == | Desc: 收藏列表
 == ============================================================================
*/%>
<%/*
json数据样式
    {

    }
*/%>

<%
    String userId = session.getAttribute("userId")+"";
    request.setAttribute("userId",userId);
%>

{
    <cms:favorites  userId="${userId}"  pagesize="100" pageidx="1" />
    "favoriteList":[
        <c:forEach var="topic" items="${favorites}">
        {
            "id":"${topic.id}",
        },
       </c:forEach>
    ]
}
