<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/nodeid/nodeid.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2012, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: huangyuxin
 == ============================================================================
 == | Desc: 音频一级直播列表json数据
 == ============================================================================
*/%>
<%/*
json数据样式
{
    "userId":"",
    "nodeName":"",
    "catalogueAudioList": [
        {
            "img":"",
            "param":"freePlayId=xxxx",
            "name":"",
        },
        {
            "img":"",
            "param":"liveId=xxxx",
            "name":"",
        },
        {
            "img":"",
            "param":"nodeId=xxx",
            "name":"",
        },
    ]
}
*/%>
{

    
    <c:if test="${!empty param.nodeId}">
        <cms:nodeUser nodeId="${param.nodeId}"/>
        "userId":"${nodeUser}",
        <cms:node var="curNode" nodeid="${param.nodeId}" />
        "nodeName":"${curNode.name}",
    </c:if>

    "catalogueAudioList":[
        <cms:nodecont var="catalogueNode" nodeid="${param.nodeId}" dataobjectid="1" sortKey="ranking" pagesize="50" />
        <c:forEach var="curCont" items="${catalogueNode}">
            <%//↓↓↓↓↓Json构成↓↓↓↓↓%>
            {
                <c:if test="${!empty curCont.fields.IMAGES}">
                "img":"${cpath}/publish/clt${curCont.fields.IMAGES[0].src}",
                </c:if>
                <c:if test="${empty curCont.fields.IMAGES}">
                "img":"",
                </c:if>
                "param":"${curCont.fields.LINKS}",
                "name":"${curCont.name}",
            },
            <%//↑↑↑↑↑Json构成↑↑↑↑↑%>
        </c:forEach>
    ]
}
