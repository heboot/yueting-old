<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2011, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: lumin <lumin@mantis.com>
 == ============================================================================
 == | Desc: 详情页数据模板
 == ============================================================================
*/%>
<%/*
json数据样式
    {
        "isFavorited":"${isFavorited}",
        "favoritesid":"${delID}",
    }
*/%>
{
    <c:set var="isFavorited" value="0" />
    <c:set var="delID" value="" />
    <cms:favorites var="myFavorites" isAll="1"/><%//获取当前手机号收藏集合%>
    <c:forEach var="oneFavourte" items="${myFavorites.canPlayFavorites}" varStatus="status">
        <c:if test="${!empty param.contentId}">
            <c:if test="${oneFavourte.contentId != '' && oneFavourte.contentId != null && oneFavourte.contentId != 'null'}"><%//收藏的是内容%>
                <c:if test="${oneFavourte.contentId==param.contentId}">
                    <c:set var="isFavorited" value="1" />
                    <c:set var="delID" value="${oneFavourte.favoritesid}" />
                </c:if>
            </c:if>
        </c:if>
        <c:if test="${empty param.contentId}">
            <c:if test="${ empty oneFavourte.contentId && oneFavourte.nodeId == param.nodeId}">
                <c:set var="isFavorited" value="1" />
                <c:set var="delID" value="${oneFavourte.favoritesid}" />
            </c:if>
        </c:if>
    </c:forEach>
    "isFavorited":"${isFavorited}",
    "favoritesid":"${delID}",
}
