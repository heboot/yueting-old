<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/nodeid/nodeid.jsp"%>
<%/*
 == ============================================================================
 == | WonderTek [ 网络无处不在，沟通及时到达 ]
 == ============================================================================
 == | Copyright (c) 2011, WonderTek, Inc. All Rights Reserved.
 == ============================================================================
 == | Author: cuiyizhou
 == ============================================================================
 == | Desc: 首页独立数据
 == ============================================================================
*/%>
{
"postList":[
    <cms:nodecont var="homePanoramaCont" nodeid="${homePanoramaId}" dataobjectid="1" pagesize="10" sortKey="ranking" sortType="desc"/>
    <c:forEach var="content" items="${homePanoramaCont}" varStatus="status">
        <c:if test="${!empty content.fields.IMAGES}">
            <c:forEach var="nodeImg" items="${content.fields.IMAGES}">
                <c:set var="cimage" value="${cpath}/publish/clt${nodeImg.src}" />
            </c:forEach>
        </c:if>
        <c:if test="${empty content.fields.IMAGES}">
            <c:set var="cimage" value="" />
        </c:if>
        <c:set var="links" value="${fn:split(content.fields.LINKS,'=')}"/>
        <c:if test="${links[0] == 'contentId'}">
            <c:set var="cidParam" value="${content.fields.LINKS};objType=content;"/>
        </c:if>
        <c:if test="${links[0] == 'liveId'}">
            <c:set var="cidParam" value="${content.fields.LINKS};objType=live;"/>
        </c:if>
        <c:if test="${links[0] == 'nodeId'}">
            <cms:node var="contNode" nodeid="${links[1]}" />
            <c:set var="cidParam" value="${content.fields.LINKS};objType=${contNode.lookType};"/>
        </c:if>
        {
            "cid":"${cidParam}",
            "cimage":"${cimage}",
            "desc":"${content.name}",
        },
    </c:forEach>
],
"recommendList":[
    <cms:nodecont var="homeRecommendCont" nodeid="${homeRecommendId}" dataobjectid="1" pagesize="100" sortKey="ranking" sortType="desc"/>
    <c:set var="clabname" value="" />
    <c:set var="cArrowData" value="" />
    <c:forEach var="content" items="${homeRecommendCont}" varStatus="status">
        <c:set var="names" value="${fn:split(content.name,'@')}" />
        <c:if test="${!empty names[1]}">
            <c:set var="cname" value="${names[1]}" />
        </c:if>
        <c:if test="${empty names[1]}">
            <c:set var="cname" value="${content.name}" />
        </c:if>
        <c:set var="links" value="${fn:split(content.fields.LINKS,'=')}"/>
        <c:set var="cprop" value="" />
        <c:set var="img" value="" />
        <c:set var="haveFreeProcut" value="0" />
        <c:if test="${links[0] == 'contentId'}">
            <cms:content var="cont" contid="${links[1]}" />
            <cms:node var="contNode" nodeid="${cont.fields.NODEID}" />
            <c:set var="cprop" value=""/>
            <c:set var="cparam" value="contentId=${cont.contId};nodeId=${cont.fields.NODEID};objType=content;"/>
            <c:set var="img" value="${cpath}/publish/image/${cont.fields.DISPLAYFILELISTS}/${cont.fields.HW_CID}/display/${cont.fields.UDID}_${imgContType}" />
        </c:if>
        <c:if test="${links[0] != 'contentId'}">
            <c:if test="${links[0] == 'liveId'}">
                <cms:node var="contNode" nodeid="${links[1]}" />
                <c:set var="cprop" value=""/>
                <c:set var="cparam" value="${content.fields.LINKS};objType=live;"/>
            </c:if>
            <c:if test="${links[0] == 'nodeId'}">
                <cms:node var="contNode" nodeid="${links[1]}" />
                <c:set var="cprop" value=""/>
                <c:if test="${contNode.lookType == '1' || contNode.lookType == '4'}">
                    <c:set var="cprop" value="${contNode.fields.property4}" />
                </c:if>
                <c:if test="${contNode.lookType == '5' }">
                    <cms:nowliving var="nowLiving" nodeid="${links[1]}" />
                    <c:set var="cprop" value="${nowLiving.name}" />
                </c:if>
                <c:set var="cparam" value="${content.fields.LINKS};objType=${contNode.lookType};"/>

                <c:set var="freeID" value="2028593140;2028593456;2028593112;2028593253;2028593111;2028593110;2028593357;2028593163;2028593359;2028593167;2028593356;2028593109;2028593355;2028593107;2028593108;2028593168"/>
                <cms:nodeproduct var="productss" nodeid="${links[1]}" />
                <c:forEach var="pdts" items="${productss}" varStatus="pstatus">
                    <c:if test="${fn:contains(freeID,pdts.productId)}">
                        <c:set var="haveFreeProcut" value="1"/>
                    </c:if>
                </c:forEach>
                <cms:nodevisit var="nodevisits" nodeid="${links[1]}" ifWrite="0" />
            </c:if>
            <c:if test="${!empty content.fields.IMAGES}">
                <c:forEach var="nodeImg" items="${content.fields.IMAGES}">
                    <c:set var="img" value="${cpath}/publish/clt${nodeImg.src}" />
                </c:forEach>
            </c:if>
        </c:if>
        {
            "cname":"${cname}",
            "cid":"${cparam}",
            "clabname":"${clabname}",
            "cimage":"${img}",
            "cprop":"${cprop}",
            "cArrowData":"${cArrowData}",
            "free":"${haveFreeProcut}",
            "count":"${nodevisits}",
        },
    </c:forEach>
],
"saleImgList":[
    <c:set var="i" value="0" />
    <cms:nodecont var="saleImgConts" nodeid="${saleImgId}" dataobjectid="1" pagesize="1"/> <%//营销页用图栏目id%>
    <c:forEach var="saleImgCont" items="${saleImgConts}">
        <c:set var="publishTime" value="" /> <%//通用对象发布时间%>
        <c:set var="saleImg" value="" /> <%//登录页背景图%>
        <c:if test="${!empty saleImgCont.publishTime && !empty saleImgCont.fields.IMAGES[0].src}"> <%//如果有通用对象且有图片%>
        {
            <c:set var="i" value="${i+1}"/>
            <c:set var="links" value="${fn:split(saleImgCont.fields.LINKS,'=')}"/>
            <c:if test="${links[0] == 'contentId'}">
                <c:set var="cidParam" value="${saleImgCont.fields.LINKS};objType=content;"/>
            </c:if>
            <c:if test="${links[0] == 'liveId'}">
                <c:set var="cidParam" value="${saleImgCont.fields.LINKS};objType=live;"/>
            </c:if>
            <c:if test="${links[0] == 'nodeId'}">
                <cms:node var="contNode" nodeid="${links[1]}" />
                <c:set var="cidParam" value="${saleImgCont.fields.LINKS};objType=${contNode.lookType};"/>
            </c:if>
            "lastModifiedSaleImg":"${saleImgCont.publishTime}",
            "saleImg":"${cpath}/publish/clt${saleImgCont.fields.IMAGES[0].src}",
            "param":"${cidParam}",
        },
        </c:if>
    </c:forEach>
],
"channelList":[
    <cms:nodecont var="homeChannelList" nodeid="${homeChannelId}" dataobjectid="1" pagesize="100" sortKey="ranking" sortType="asc"/>
    <c:forEach var="content" items="${homeChannelList}" varStatus="status">
        <c:set var="links" value="${fn:split(content.fields.LINKS,'=')}"/>
        <c:if test="${links[0] == 'nodeId'}">
            <c:set var="i" value="0" />
            <cms:nodecont var="homeChannelTab" nodeid="${links[1]}" dataobjectid="1" pagesize="100" sortKey="ranking" sortType="desc"/>
            <c:forEach var="tabcontent" items="${homeChannelTab}" varStatus="status">
                <c:set var="links" value="${fn:split(tabcontent.fields.LINKS,'=')}"/>
                <cms:nodecont var="contentNode" nodeid="${links[1]}" dataobjectid="1" pagesize="9999" sortKey="ranking" sortType="desc"/>
                <c:set var="i" value="${i + fn:length(contentNode)}" />
            </c:forEach>
        {
            "name":"${content.name}",
            "param":"${content.fields.LINKS}",
            "prop":"${i}",
        },
        </c:if>
    </c:forEach>
],
}
