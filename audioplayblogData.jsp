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
{
    "name":"",
    "desc":"",
    "isSupPilot":"",
    "img":"",
    "voteContId":"",
    "voteId":"",
    "score":"",
    "propertyInfo":"property3",
    "fileLength":"",
    "contvisit":"",
    "keyword":"",
    "voteId1":"200000677",
    "optId1":"200000844",
    "voteId2":"200000657",
    "optId2":"200000834",
    "contList":[
        {
            "name":"",
            "param":"",
            "fileLength":"",
            "isFree":"",
        },
        {
            "name":"",
            "param":"",
            "fileLength":"",
            "isFree":"",
        },
    ],

}
*/%>
{
    <c:if test="${!empty param.objType}">
        <cms:isLogin loginMode="${param.filterType}" clientId="${param.clientId}" />
        <c:if test="${empty isLogin}">
            "code":"1014",
        </c:if>
        <c:if test="${!empty isLogin}">
            "code":"1010",
        </c:if>
        <c:if test="${param.objType == '20'}">
            <cms:content var="cont" contid="${param.contentId}" />
            "himg":"${cpath}/publish/image/${cont.fields.DISPLAYFILELISTS}/${cont.fields.HW_CID}/display/${cont.fields.UDID}_${imgContType2}",
            "param":"objType=0;contentId=${cont.contId};nodeId=${cont.fields.NODEID};",
            "name":"${cont.name}",
            "contvisit":"${cont.fields.FILMLENGTH}",
            "desc":"${cont.fields.DESCRIPTION}",
            "voteId1":"200000677",
            "optId1":"200000844",
            "voteId2":"200000657",
            "optId2":"200000834",

            "contList":[
            {
                "name":"${cont.name}",
                "fileLength":"${cont.fields.FILMLENGTH}",
                "img":"${cpath}/publish/image/${cont.fields.DISPLAYFILELISTS}/${cont.fields.HW_CID}/display/${cont.fields.UDID}_${imgContType2}",
                
                <cms:contvisit contid="${curCont.contId}"/>
                "playTimes":"${contvisit}",
                "param":"objType=0;contentId=${cont.contId};nodeId=${cont.fields.NODEID};",

                <c:if test="${!empty param.microBlogId}">
                <cms:detailBlog microBlogId="${param.microBlogId}" />
                    "favTimes":"${microBlog.favTimes}",
                </c:if>
                <c:if test="${empty param.microBlogId}">
                    "favTimes":"0",
                </c:if>
                },
            ],
        </c:if>
    </c:if>
    <c:if test="${empty param.objType}">
        {
            "name":"",
            "sendBtnData":"",
            "description":"",
            "img":"",
            "score":"",
            "voteContId":"",
            "voteId":"",
            "propertyInfo":"",
            "fileLength":"",
            "contvisit":"",
            "contList":[

            ],
        }
    </c:if>

}
