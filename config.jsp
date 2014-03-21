<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2013, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: cuiyizhou <cuiyizhou@wondertek.com.cn>
 == ============================================================================
 == | Desc: 定义模板版本号及图片多分辨率适配
 == ============================================================================
*/%>
<%
String channelId = request.getHeader("X_UP_CLIENT_CHANNEL_ID");
request.getSession().setAttribute("channelId", channelId);

String networkType = request.getHeader("X-UP-BEAR-TYPE");
request.getSession().setAttribute("networkType", networkType);
%>
<%//网络类型标志，0为GPRS/EDGE,1为TD-SCDMA,2为WLAN %>
<c:set var="networkFlag" value="0" />
<c:set var="networkTypeDesc" value="${networkType}" /> <%//取http头上报网络类型标志%>
<c:if test="${networkTypeDesc == 'GPRS/EDGE'}" >
    <c:set var="networkFlag" value="0" />
</c:if>
<c:if test="${networkTypeDesc == 'TD-SCDMA'}" >
    <c:set var="networkFlag" value="1" />
</c:if>
<c:if test="${networkTypeDesc == 'WLAN'}" >
    <c:set var="networkFlag" value="2" />
</c:if>


<%//封闭渠道号标记，1为封闭渠道，0为主渠道%>
<c:set var="channelFlag" value="0" />
<c:set var="clientChannelId" value="${channelId}" /> <%//取http头上报的渠道号%>
<%/*<cms:channelNode />取渠道对应的节点，如渠道关闭返回空
<c:set var="clientChannelNode" value="${channelNode}" />*/%>

<c:if test="${!empty clientChannelId && !empty clientChannelNode && clientChannelNode!='' }">
    <c:set var="channelLinks" value="${fn:split(clientChannelId,'-')}" />
    <c:if test="${!empty channelLinks[1] && channelLinks[1] != '99000'}">
        <c:set var="channelFlag" value="1" />
    </c:if>
</c:if>

<c:set var="imgType" value="MDPI"/>
<c:if test="${!empty param.res}">
    <c:set var="imgType" value="${param.res}" />
</c:if>
<c:set var="nodeImgType" value="3.0.4.0_VGA"/><%//定义通用对象和栏目图片格式%>
    
<c:set var="imgContType" value="cifl.png"/>
<c:set var="imgContType2" value="cifl.png"/>
<c:if test="${!empty param.res}">
    <c:if test="${param.res == 'SDPI' }">
        <c:set var="imgContType" value="qvgal.png"/>
        <c:set var="imgContType2" value="qvgal.png"/>
    </c:if>
    <c:if test="${param.res == 'MDPI'}">
        <c:set var="imgContType" value="cifl.png"/>
        <c:set var="imgContType2" value="IPHONE.png"/>
    </c:if>
    <c:if test="${param.res == 'HDPI'}">
        <c:set var="imgContType" value="wvgal.png"/>
        <c:set var="imgContType2" value="IPHONE.png"/>
    </c:if>
</c:if>
