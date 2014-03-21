<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/nodeid/nodeid.jsp"%><%//静态加载nodeid模板%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2012, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: lumin <lumin@wdit.com.cn>
 == ============================================================================
 == | Desc: 我的订购json数据
 == ============================================================================
*/%>
<%/*
json数据样式
{
    "monthList":[ //包月产品列表
        {
            "productId":"",
            "productName":"",
            "desc":"",
        }
    ],
    "timesList":[ //按次产品列表
        {
            "productId":"",
            "productName":"",
            "desc":"",
            "cancelTime":""
        },
        {
            "productId":"",
            "productName":"",
            "desc":"",
            "cancelTime":""
        },
    ],
    "myorderProductId": "",
    "desc":"",
    "title":"",
    "tt": "",
    "ys": "",
    "contSetIds": ""
}
*/%>
<cms:musicOrderList/>
<c:set var="monthProdcuts" value="${musicOrderList.monthProdcuts}" />
<c:set var="timesProdcuts" value="${musicOrderList.timesProdcuts}" />
<c:set var="contSetIds" value="0" />
{
    "monthList":[
        <c:if test="${!empty monthProdcuts[0] && monthProdcuts[0].chargeMode == 0}">
            <c:if test="${!empty monthProdcuts[0].pdesc}">
                <c:set var="desc" value="${monthProdcuts[0].pdesc}" />
            </c:if>
            <c:if test="${empty monthProdcuts[0].pdesc}">
                <c:set var="desc" value="${monthProdcuts[0].description}" />
            </c:if>
        {
            "productId":"${monthProdcuts[0].productID}",
            "productName":"${monthProdcuts[0].name}",
            "desc":"${desc}"
        }
        </c:if>
    ],
    "timesList":[
    <c:forEach var="oneTimesProdcut" items="${timesProdcuts}">
        <c:if test="${oneTimesProdcut.chargeMode == 1}">
            <c:if test="${!empty oneTimesProdcut.pdesc}">
                <c:set var="desc" value="${oneTimesProdcut.pdesc}" />
            </c:if>
            <c:if test="${empty oneTimesProdcut.pdesc}">
                <c:set var="desc" value="${oneTimesProdcut.description}" />
            </c:if>
            <c:if test="${oneTimesProdcut.contentType == '1'}"><%//内容按次%>
                <cms:content var="oneTimesContent" contid="${oneTimesProdcut.nodeInfo}" />
                <c:if test="${!empty oneTimesContent.contId}">
                    <c:set var="productName" value="${oneTimesContent.name}" />
                </c:if>
                <c:if test="${empty oneTimesContent.contId}">
                    <c:set var="productName" value="${oneTimesProdcut.name}" />
                </c:if>
            </c:if>
            <c:if test="${oneTimesProdcut.contentType == '2'}"><%//内容集按次%>
                <c:set var="nodeInfo" value="${oneTimesProdcut.nodeInfo}" />
                <cms:node var="oneTimesNode" nodeid="${musicOrderList.contSet_node[nodeInfo]}" />
                <c:set var="contSetIds" value="${contSetIds};${musicOrderList.contSet_node[nodeInfo]}" />
                <c:if test="${!empty oneTimesNode.nodeId}">
                    <c:set var="productName" value="${oneTimesNode.name}" />
                </c:if>
                <c:if test="${empty oneTimesNode.nodeId}">
                    <c:set var="productName" value="${oneTimesProdcut.name}" />
                </c:if>
            </c:if>
        {
            "productId":"${oneTimesProdcut.productID}",
            "productName":"${productName}",
            "desc":"${desc}",
            <c:if test="${fn:length(oneTimesProdcut.orderEndTime) < 12}">
                <c:set var="orderEndTime" value="${oneTimesProdcut.orderEndTime}" />
            </c:if>
            <c:if test="${fn:length(oneTimesProdcut.orderEndTime) >= 12}">
                <c:set var="year" value="${fn:substring(oneTimesProdcut.orderEndTime, 0, 4)}"/>
                <c:set var="month" value="${fn:substring(oneTimesProdcut.orderEndTime, 4, 6)}"/>
                <c:set var="day" value="${fn:substring(oneTimesProdcut.orderEndTime, 6, 8)}"/>
                <c:set var="hour" value="${fn:substring(oneTimesProdcut.orderEndTime, 8, 10)}"/>
                <c:set var="minute" value="${fn:substring(oneTimesProdcut.orderEndTime, 10, 12)}"/>
                <c:set var="orderEndTime" value="${year}/${month}/${day} ${hour}:${minute}" />
            </c:if>
            "cancelTime":"${orderEndTime}"
        },
        </c:if>
    </c:forEach>
    ],
    "myorderProductId": "${myorderProductId}",
    <cms:product var="myorderProduct" productid="${myorderProductId}" />
    <c:if test="${!empty myorderProduct.pdesc}">
        <c:set var="desc" value="${myorderProduct.pdesc}" />
    </c:if>
    <c:if test="${empty myorderProduct.pdesc}">
        <c:set var="desc" value="${myorderProduct.description}" />
    </c:if>
    "desc": "${desc}",
    "title": "包月, ${myorderProduct.price/100}元/月",
    "tt": "${musicOrderList.tt}",
    "ys": "${musicOrderList.ys}",
    "contSetIds": "${contSetIds}"
}