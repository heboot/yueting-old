<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2012, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: huangyuxin
 == ============================================================================
 == | Desc: 音频二级直播列表json数据(电台、随心听)
 == ============================================================================
*/%>
<%/*
json数据样式(freePlayList 或 livePlayList )
{
    "audioNodeId": "",
    "objType":"",
    "freePlayList": [
        {
            "param":"objType=freePlay;contentId=xxx;nodeId=xxx;",
            "name":"",
        },
        {
            "param":"",
            "name":"",
        },{
            "param":"",
            "name":"",
        },
    ],
    
    "livePlayList": [
        {
            "param":"objType=live;contentId=xxx;nodeId=xxx;",
            "name":"",
            "sTime":"",
            "eTime":"",
        },
        {
            "param":"",
            "name":"",
            "sTime":"",
            "eTime":"",
        },{
            "param":"",
            "name":"",
            "sTime":"",
            "eTime":"",
        },
    ] 
}
*/%>
{
    "audioNodeId":"${param.nodeId}",
    "objType":"${param.objType}",
    "freePlayList":[
    <c:if test="${param.objType == 'freePlay'}" >  <%// 随心听数据 %> 
        <cms:randomMusic var="musics" nodeid="${param.nodeId}"/>
        <c:forEach var="music" items="${musics}">
            <cms:content contid="${music.contId}"/>
            <%//↓↓↓↓↓Json构成↓↓↓↓↓%>
            {
                "param":"objType=freePlay;contentId=${music.contId};nodeId=${music.nodeId};",
                "name":"${music.name}"
            },
            <%//↑↑↑↑↑Json构成↑↑↑↑↑%>
        </c:forEach>
    </c:if>
    ],  
  
    "livePlayList":[
    <c:if test="${param.objType == 'live'}" >  <%// 直播电台数据 %>  
        <cms:living var="todayLiveCont" nodeid="${param.nodeId}" day="0" />
        <c:forEach var="content" items="${todayLiveCont}" varStatus="status">
            {
                "param":"objType=live;contentId=${content.id};nodeId=${param.nodeId};",                    
                "name":"${content.name}",
                "sTime":"<cms:timeutil time="${content.startTime}" type="1"/>",
                "eTime":"<cms:timeutil time="${content.endTime}" type="1"/>"
            },
        </c:forEach>
    </c:if>
    ]    

}
