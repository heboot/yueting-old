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
 == | Author: lumin <lumin@mantis.com>
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
            "himg":"${cpath}/publish/image/${cont.fields.DISPLAYFILELISTS}/${cont.fields.HW_CID}/display/${cont.fields.UDID}_${imgContType}",
            "param":"objType=0;contentId=${cont.contId};nodeId=${cont.fields.NODEID};",
            "name":"${cont.name}",
            "contvisit":"${cont.fields.FILMLENGTH}",
            "desc":"${cont.fields.DESCRIPTION}",
            "voteId1":"200000677",
            "optId1":"200000844",
            "voteId2":"200000657",
            "optId2":"200000834",
            <cms:nodeUser nodeId="${param.nodeId}"/>
            "userId":"${nodeUser}",

            "contList":[
            {
                "name":"${cont.name}",
                "fileLength":"${cont.fields.FILMLENGTH}",
                "img":"${cpath}/publish/image/${cont.fields.DISPLAYFILELISTS}/${cont.fields.HW_CID}/display/${cont.fields.UDID}_${imgContType}",
                
                <cms:contvisit contid="${curCont.contId}" ifWrite="0"/>
                "playTimes":"${contvisit}",
                "param":"objType=0;contentId=${cont.contId};nodeId=${cont.fields.NODEID};",
                },
            ],
        </c:if>
        <c:if test="${param.objType == '2' || param.objType == '3' || param.objType == 'content' }"><%//横图详情%>
            <cms:content var="topCont" contid="${param.contentId}" /><%//当前内容对象%>
            <cms:node var="topNode" nodeid="${param.nodeId}" /><%//当前内容对象所属栏目%>
            "name":"${topCont.name}",
            "nodename":"${topNode.name}",
            "desc":"${topCont.fields.DESCRIPTION}",
            "voteId1":"200000677",
            "optId1":"200000844",
            "voteId2":"200000657",
            "optId2":"200000834",
            "isSupPilot":"${curCont.fields.IS_SUPPORT_PILOT}",
            "isAudio":"${topNode.isVoice}",
            <cms:score contid="${param.contentId}" voteid="${topCont.fields.VOTEID}"/>
            "score":"${score}",
            "voteContId":"${param.contentId}",
            "voteId":"${topCont.fields.VOTEID}",
            "propertyInfo":"",
            "fileLength":"${topCont.fields.FILMLENGTH}",
            "img":"${cpath}/publish/image/${topCont.fields.DISPLAYFILELISTS}/${topCont.fields.HW_CID}/display/${topCont.fields.UDID}_${imgContType}",
            <cms:nodecont var="curList" nodeid="${param.nodeId}" dataobjectid="2" pagesize="1"/>
            <c:set var="imgsrc" value="${cpath}/publish/image/${curList[0].fields.DISPLAYFILELISTS}/${curList[0].fields.HW_CID}/display/${curList[0].fields.UDID}_${imgContType}" />
            <c:set var="imagefilter" value="V${imgType}" />
            <c:forEach var="nodeImg" items="${topNode.nodeImages}">
                <c:if test="${!empty nodeImg && fn:contains(nodeImg.fileType, imagefilter)}">
                    <c:set var="imgsrc" value="${cpath}/publish/clt${nodeImg.src}" />
                </c:if>
            </c:forEach>
            "himg":"${imgsrc}",
            "contvisit":"<cms:contvisit contid="${param.contentId}"/>",
            "keyword":"${topCont.fields.KEYWORDS}",
            "contList":[

            ],
        </c:if>
        <c:if test="${param.objType == '0' || param.objType == '1' || param.objType == '4' }">
            <cms:node var="curNode" nodeid="${param.nodeId}" /><%//当前内容对象所属栏目%>
            <c:set var="nodeName" value="${curNode.name}" />
            <c:if test="${nodeName == '全片播放' || nodeName == '剧集' || nodeName == '全片'}">
                <cms:node var="pNode" nodeid="${curNode.nodeNet.parentId}" />
                <c:set var="nodeName" value="${pNode.name}" />
            </c:if>
            <cms:nodeUser nodeId="${param.nodeId}"/>
            "userId":"${nodeUser}",
            "name":"${nodeName}",
            "nodename":"",
            "desc":"${curNode.fields.property3}",
            "voteId1":"200000677",
            "optId1":"200000844",
            "voteId2":"200000657",
            "optId2":"200000834",
            "isSupPilot":"${curNode.isSupPilot}",
            "isAudio":"${curNode.isVoice}",
            <c:set var="haveImg" value="0" />
            <c:set var="imagefilter" value="H${imgType}" />
            <c:forEach var="nodeImg" items="${curNode.nodeImages}">
                <c:if test="${!empty nodeImg && fn:contains(nodeImg.fileType, imagefilter)}">
                    <c:set var="haveImg" value="1" />
            "img":"${cpath}/publish/clt${nodeImg.src}",
                </c:if>
            </c:forEach>
            <c:if test="${haveImg == 0}">
            "img":"${cpath}/publish/image/${curNode.fields.DISPLAYFILELISTS}/${curNode.fields.HW_CID}/display/${curNode.fields.UDID}_${imgContType}",
            </c:if>
            <c:set var="haveImg" value="0" />
            <c:set var="imagefilter" value="V${imgType}" />
            <c:forEach var="nodeImg" items="${curNode.nodeImages}">
                <c:if test="${!empty nodeImg && fn:contains(nodeImg.fileType, imagefilter)}">
                    <c:set var="haveImg" value="1" />
            "himg":"${cpath}/publish/clt${nodeImg.src}",
                </c:if>
            </c:forEach>
            <c:if test="${haveImg == 0}">
            "himg":"${cpath}/publish/image/${curNode.fields.DISPLAYFILELISTS}/${curNode.fields.HW_CID}/display/${curNode.fields.UDID}_${imgContType}",
            </c:if>
            "propertyInfo":"${curNode.fields.property4}",
            "contList":[
            <c:set var="_pageSize" value="30" />
            <c:if test="${param.objType == '1' }">
                <c:set var="_pageSize" value="1000" />
            </c:if>
            <c:set var="_pageIndex" value="1" />
            <c:if test="${param.objType == '0' }">
                <c:if test="${!empty param.pageIdx}">
                    <c:set var="_pageIndex" value="${param.pageIdx}" />
                </c:if>
            </c:if>
            <cms:nodecont var="curList" nodeid="${param.nodeId}" dataobjectid="2" pagesize="${_pageSize}" pageidx="${_pageIndex}" sortKey="ranking" sortType="desc"/>
            <c:set var="firstContId" value="" />
            <c:set var="firstVoteId" value="" />
            <c:set var="_keyword" value="" />
            <c:set var="freeDetect" value="1" />
            <c:set var="havefree" value="0" />
            <c:set var="productIDs" value=""/>
            <c:forEach var="curCont" items="${curList}" varStatus="status">
            {
                <c:if test="${status.index==0}">
                    <c:set var="firstContId" value="${curCont.contId}" />
                    <c:set var="firstVoteId" value="${curCont.fields.VOTEID}" />
                    <c:set var="_keyword" value="${curCont.fields.KEYWORDS}" />
                </c:if>
                "name":"${curCont.name}",
                "param":"objType=${param.objType};contentId=${curCont.contId};nodeId=${param.nodeId};",
                "fileLength":"${curCont.fields.FILMLENGTH}",
                "img":"${cpath}/publish/image/${curCont.fields.DISPLAYFILELISTS}/${curCont.fields.HW_CID}/display/${curCont.fields.UDID}_${imgContType2}",
                <cms:contvisit contid="${curCont.contId}" ifWrite="0"/>
                "playTimes":"${contvisit}",
                <c:if test="${freeDetect == '1'}">
                    <c:set var="freeID" value="2028593140;2028593456;2028593112;2028593253;2028593111;2028593110;2028593357;2028593163;2028593359;2028593167;2028593356;2028593109;2028593355;2028593107;2028593108;2028593168;2028594065;2028594066;2028594067;2028594068;2028594069;2028594070;2028594071;2028594072;2028594073;2028594074;2028594075;2028594076;2028594077;2028594078;2028594079;2028594080;2028594081;2028594082;2028594083;2028594084;2028594085;2028594086;2028594087;2028594088;2028594270;2028594271;2028594272;2028594273;"/>
                    <cms:contentproduct var="products" nodeid="${param.nodeId}" contentid="${curCont.contId}"/>
                    <c:forEach var="product" items="${products}" varStatus="status">
                        <c:if test="${fn:contains(freeID,product.productID)}" >
                            <c:set var="havefree" value="1"/>
                        </c:if>
                        <c:set var="productIDs" value="${product.productID};${productIDs}" />
                    </c:forEach>
                </c:if>
                <c:if test="${havefree == '0'}">
                    "isFree":"0",
                    <c:set var="freeDetect" value="0"/>
                </c:if>
                <c:if test="${havefree == '1'}">
                    "isFree":"1",
                    <c:set var="havefree" value="0"/>
                </c:if>
            },
            </c:forEach>
            ],
            <cms:score contid="${firstContId}" voteid="${firstVoteId}"/>
            "score":"${score}",
            "voteContId":"${firstContId}",
            "voteId":"${firstVoteId}",
            <cms:nodevisit var="nodevisits" nodeid="${param.nodeId}" ifWrite="0" />
            "contvisit":"${nodevisits}",
            "keyword":"${_keyword}",
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
