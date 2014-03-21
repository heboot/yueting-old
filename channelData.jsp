<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobilevideo34/config/config.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2012, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: cuiyizhou <cuiyizhou@wondertek.com.cn>
 == ============================================================================
 == | Desc: 二级分类页分类加列表json数据
 == ============================================================================
*/%>
<%/*
json数据样式
{
    "catalogueList": [
        {
            "name":"",
            "param":""
        }
    ],
    "contentList": [
        {
            "img":"",
            "param":"nodeId=xxxx",
            "name":"",
        },
    ],
}
*/%>
{
    <%//二级分类导航数据%>
    "nodeId":"${param.nodeId}",
    "catalogueList":[
        <c:set var="listNodeId0" value=""/>
        <c:set var="focusIndex" value="0"/>
        <c:if test="${!empty param.nodeId}">
            <cms:nodecont var="catalogueNode" nodeid="${param.nodeId}" dataobjectid="1"/>
            <c:forEach var="curCont" items="${catalogueNode}" varStatus="status">
                <c:if test="${status.index == 0 && empty param.focusId}">
                    <c:set var="links" value="${fn:split(curCont.fields.LINKS,'=')}"/>
                    <c:set var="listNodeId0" value="${links[1]}"/>
                </c:if>
                <c:if test="${!empty param.focusId && fn:contains(curCont.fields.LINKS, param.focusId)}">
                    <c:set var="links" value="${fn:split(curCont.fields.LINKS,'=')}"/>
                    <c:set var="listNodeId0" value="${links[1]}"/>
                </c:if>
                <c:if test="${empty param.focusId}">
                <%//↓↓↓↓↓Json构成↓↓↓↓↓%>
                {
                    "name":"${curCont.name}",
                    "param":"${curCont.fields.LINKS}",
                    "nodeType":"0",
                },
                </c:if>
                <%//↑↑↑↑↑Json构成↑↑↑↑↑%>
            </c:forEach>
        </c:if>
    ],
        <%//二级分类当前项列表数据%>
        "contentList":[
            <c:if test="${listNodeId0 != ''}">
                <cms:node var="curNode" nodeid="${listNodeId0}" />
                <c:set var="targetId" value="${listNodeId0}"/>
                 <c:set var="pageIndex" value="1" />
                 <c:if test="${!empty param.pageIndex}">
                     <c:set var="pageIndex" value="${param.pageIndex}" />
                </c:if>
                <c:if test="${empty param.sortKey}">
                    <cms:nodecont var="oneCatalogueNode" nodeid="${targetId}" dataobjectid="1" pagesize="14" pageidx="${pageIndex}"/>
                </c:if>
                <c:if test="${!empty param.sortKey}">
                    <cms:nodecont var="oneCatalogueNode" nodeid="${targetId}" dataobjectid="1" pagesize="14" pageidx="${pageIndex}" sortKey="${param.sortKey}"/>
                </c:if>
                <c:forEach var="curCont" items="${oneCatalogueNode}">
                    <c:set var="links" value="${fn:split(curCont.fields.LINKS,'=')}"/>
                    <cms:node var="contNode" nodeid="${links[1]}" />
                    <cms:nodecont var="curList" nodeid="${links[1]}" dataobjectid="2" pagesize="1"/>
                    <c:set var="desc" value="${curList[0].fields.DESCRIPTION}"/>
                    <c:if test="${!empty contNode.description}">
                        <c:set var="desc" value="${contNode.description}"/>
                    </c:if>
                    <%//↓↓↓↓↓Json构成↓↓↓↓↓%>
                    {
                        <c:set var="haveImg" value="0" />
                        <c:set var="imagefilter" value="_V${imgType}" />
                        <c:forEach var="nodeImg" items="${contNode.nodeImages}">
                            <c:if test="${!empty nodeImg && fn:contains(nodeImg.fileType, imagefilter)}">
                                <c:set var="haveImg" value="1" />
                        "img":"${cpath}/publish/clt${nodeImg.src}",
                            </c:if>
                        </c:forEach>
                        <c:if test="${haveImg == 0}">
                        "img":"${cpath}/publish/image/${curList[0].fields.DISPLAYFILELISTS}/${curList[0].fields.HW_CID}/display/${curList[0].fields.UDID}_${imgContType}",
                        </c:if>
                        <c:set var="objType" value="${curNode.lookType}" />
                        <c:if test="${links[0] == 'contentId'}">
                            <c:set var="objType" value="content" />
                        </c:if>
                        <c:if test="${links[0] == 'nodeId'}">
                            <cms:node var="curNode" nodeid="${links[1]}" />
                            <c:set var="objType" value="${curNode.lookType}" />
                            <cms:nodevisit var="nodevisits" nodeid="${links[1]}" ifWrite="0" />
                        </c:if>
                        "param":"${curCont.fields.LINKS};objType=${objType};",
                        "name":"${curCont.name}",
                        "desc":"${contNode.fields.property3}",
                        "prop":"${contNode.fields.property4}",
                        "count":"${nodevisits}",
                    },
                    <%//↑↑↑↑↑Json构成↑↑↑↑↑%>
                </c:forEach>
            </c:if>
        ],
}
