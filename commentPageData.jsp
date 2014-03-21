<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
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
 == | Desc: 详情页评论数据
 == ============================================================================
*/%>
<%/*
json数据样式
{
    in：pageIndex;pageSize;objectId;objecttype
     "commentList":[
        {
            "mobile":"",
            "content":"",
            "checkTime":"",
        },
    ],
    "commentCount":"",
}
*/%>
{
    <c:if test="${!empty param.objectId}">
        <c:set var="_pageSize" value="20" />
        <c:if test="${!empty param.pageSize}">
            <c:set var="_pageSize" value="${param.pageSize}" />
        </c:if>
        <c:set var="_pageIndex" value="1" />
        <c:if test="${!empty param.pageIndex}">
            <c:set var="_pageIndex" value="${param.pageIndex}" />
        </c:if>
        <cms:commentList contId="${param.objectId}"  objectType="${param.objectType}" pageIndex ="${_pageIndex}" pageSize ="${_pageSize}"/>
        "commentList":[
            <c:forEach var="comment" items="${commentList}" varStatus="index">
            {
                "mobile":"${comment.mobile}",
                "content":"${comment.content}",
                "checkTime":"${comment.checkTime}",
            },
            </c:forEach>
        ],
        "commentCount":"${count}",
    </c:if>
    <c:if test="${empty param.objectId}">
      "commentList":[
                
        ],
      "commentCount":"0",
    </c:if>
}
