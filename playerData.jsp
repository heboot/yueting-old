<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/publish/clt/resource/mobileaudio3/config/config.jsp"%>
<%/*
json数据样式
播放数据
{
    "titleName":"",
    "nodeName":"",
    "objType":"",
    "playUrl":"",
    "param":"",
    "img":"",
    "liveList":[
        {
            "sTime":"",
            "eTime":"",
            "name":"",
        },
    ],
    "preparam":"",
    "nextparam":"",
    "subList":[
        {
            "name":"",
            "param":"",
        },
        {
            "name":"",
            "param":"",
        },
    ],
    "curDay":"",
    "sTime":"",
    "eTime":"",
    "supportRate":"rate1=9_10;rate2=12_10;rate3=14_10;rate4=xx_xx;",
    "matchedRate":"rate3",
    ],
}

或订购数据
{
    "appointment":"false",
    "orderList":[
            {
                "secret":"",
                "typeName":"",
                "title":"",
                "contparam":"",
                "desc":""
            },
            {
                "secret":"",
                "typeName":"",
                "title":"",
                "contparam":"",
                "desc":""
            },
            {
                "secret":"",
                "typeName":"",
                "title":"",
                "contparam":"",
                "desc":""
            },
    ]
}

或未登录数据
{
    "code":"1014",
}

或错误数据
{
    "errordesc":"",
}
*/%>
<c:if test="${!empty param.contentId && !empty param.objType}">
    <cms:content var="curCont" contid="${param.contentId}" />
    <c:if test="${empty param.nodeId || param.nodeId == ''}">
        <c:set var="curNodeId" value="${curCont.fields.NODEID}"/>
    </c:if>
    <c:if test="${!empty param.nodeId}">
        <c:set var="curNodeId" value="${param.nodeId}"/>
    </c:if>
    <cms:node var="curNode" nodeid="${curNodeId}" />
    <c:set var="objType" value="${param.objType}"/>
    <c:set var="haveImg" value="0" />
    <c:forEach var="nodeImage" items="${curNode.nodeImages}">
        <c:if test="${!empty nodeImage && fn:contains(nodeImage.fileType, 'PLYVHDPI')}">
            <c:set var="haveImg" value="1" />
            <c:set var="curImg" value="${cpath}/publish/clt${nodeImage.src}"/>
        </c:if>
    </c:forEach>
    <c:if test="${haveImg == 0}" >
        <c:set var="curImg" value=""/>
    </c:if>
    <c:if test="${!empty param.rate}">
        <c:set var="curRate" value="rate${param.rate}"/>
    </c:if>
    <c:set var="rateParam" value=""/>
    <c:if test="${param.objType eq 'live' || param.objType eq 'review'}">
        <%/*获取可用码率*/%>
        <c:if test="${!empty param.live}">
            <cms:nowliving var="nowLiving" nodeid="${curNode.nodeId}" />
            <cms:content var="curCont" contid="${nowLiving.id}" />
        </c:if>
        <cms:mediaList var="mediaList" nodeid="${curNode.nodeId}" liveid="${curCont.contId}" />
        <c:if test="${mediaList != null}">
            <%/*码率匹配,如果适配不到该码率，则自动降低一级码率适配*/%>
            <c:set var="rateParam" value="rate3=${mediaList.rate3};rate2=${mediaList.rate2};rate1=${mediaList.rate1};"/>
            <c:set var="curRateValue" value="rate${param.rate}"/>
            <c:set var="uc_mt" value=""/>
            <c:set var="matchedRate" value=""/> <%/*当前匹配的码率*/%>
            <c:set var="rateParams" value="${fn:split(rateParam, ';')}"/>
            <c:forEach var="rateItems" items="${rateParams}" begin="0" end="3" step="1" varStatus="index">
                <c:set var="rate_ucmt" value="${fn:split(rateItems, '=')}"/>
                <c:if test="${rate_ucmt[0] == curRateValue }">
                    <c:if test="${not empty rate_ucmt[1] && matchedRate ==''}">
                        <c:set var="uc_mt" value="${rate_ucmt[1]}"/>
                        <c:set var="matchedRate" value="${rate_ucmt[0]}"/>
                    </c:if>
                    <c:if test="${empty rate_ucmt[1] && matchedRate ==''}"> <%/*自动降低一级码率适配*/%>
                        <c:set var="curRateValue" value="rate${3- index.index}"/>
                    </c:if>
                </c:if>
            </c:forEach>
            
            <c:set var="uc_mts" value="${fn:split(uc_mt, '_')}"/>
            <c:if test="${empty param.live}">
                <c:set var="objType" value="review"/>
            </c:if>
            <%/*取播放地址*/%>
            <cms:supPlayUrl var="playurl" nodeid="${curNode.nodeId}" liveid="${curCont.contId}" uc="${uc_mts[0]}" mt="${uc_mts[1]}" />
        </c:if>
    </c:if>
    <c:if test="${param.objType eq 'content' || param.objType eq '0' || param.objType eq '1' || param.objType eq '2' || param.objType eq '3' || param.objType eq '4' || param.objType eq 'community'}">
        <%/*获取可用码率*/%>
        <cms:mediaList var="mediaList" nodeid="${curNode.nodeId}" contid="${curCont.contId}" />
        <c:if test="${mediaList != null}">
            <%/*码率匹配,如果适配不到该码率，则自动降低一级码率适配*/%>
            <c:set var="rateParam" value="rate4=${mediaList.rate4};rate3=${mediaList.rate3};rate2=${mediaList.rate2};rate1=${mediaList.rate1};"/>
            <c:set var="curRateValue" value="rate${param.rate}"/>
            <c:set var="uc_mt" value=""/>
            <c:set var="matchedRate" value=""/> <%/*当前匹配的码率*/%>
            <c:set var="rateParams" value="${fn:split(rateParam, ';')}"/>
            <c:forEach var="rateItems" items="${rateParams}" begin="0" end="3" step="1" varStatus="index">
                <c:set var="rate_ucmt" value="${fn:split(rateItems, '=')}"/>
                <c:if test="${rate_ucmt[0] == curRateValue }">
                    <c:if test="${not empty rate_ucmt[1] && matchedRate ==''}">
                        <c:set var="uc_mt" value="${rate_ucmt[1]}"/>
                        <c:set var="matchedRate" value="${rate_ucmt[0]}"/>
                    </c:if>
                    <c:if test="${empty rate_ucmt[1] && matchedRate ==''}"> <%/*自动降低一级码率适配*/%>
                        <c:set var="curRateValue" value="rate${3- index.index}"/>
                    </c:if>
                </c:if>
            </c:forEach>
            
            <c:set var="uc_mts" value="${fn:split(uc_mt, '_')}"/>
            <%/*取播放地址*/%>
            <cms:supPlayUrl var="playurl" nodeid="${curNode.nodeId}" contid="${curCont.contId}" uc="${uc_mts[0]}" mt="${uc_mts[1]}" />
        </c:if>
        <cms:mediaList var="mediaListdownload" nodeid="${curNode.nodeId}" contid="${curCont.contId}" ifDownload="1"/>
        <c:if test="${mediaList != null}">
            <%/*码率匹配,如果适配不到该码率，则自动降低一级码率适配*/%>
            <c:set var="rateParamDownload" value="rate4=${mediaListdownload.rate4};rate3=${mediaListdownload.rate3};rate2=${mediaListdownload.rate2};rate1=${mediaListdownload.rate1};"/>
            <c:set var="curRateValue" value="rate${param.rate}"/>
            <c:set var="uc_mtdownload" value=""/>
            <c:set var="rateParams" value="${fn:split(rateParamDownload, ';')}"/>
            <c:forEach var="rateItems" items="${rateParams}" begin="0" end="3" step="1" varStatus="index">
                <c:set var="rate_ucmt" value="${fn:split(rateItems, '=')}"/>
                <c:if test="${rate_ucmt[0] == curRateValue }">
                    <c:if test="${not empty rate_ucmt[1]}">
                        <c:set var="uc_mtdownload" value="${rate_ucmt[1]}"/>
                    </c:if>
                </c:if>
            </c:forEach>
            <c:set var="uc_mtsdownload" value="${fn:split(uc_mtdownload, '_')}"/>
        </c:if>
    </c:if>
</c:if>
<c:if test="${resultCode == 1014}"> <%//未登录%>
{
    "code":"1014",
}
</c:if>
<c:if test="${resultCode == 0}">
{
    "titleName":"${curCont.name}",
    "nodeName":"${curNode.name}",
    "objType":"${objType}",
    "isAudio":"${curNode.isVoice}",
    <c:set var="pAudioDesc" value="" />
    <c:if test="${!empty curNode.fields.property4}">
        <c:set var="pAudioDesc" value="${curNode.fields.property4}" />
    </c:if>
    "audioDesc":"${pAudioDesc}",
    "playUrl":"<c:out value="${playurl}" escapeXml="true"/>",
    "param":"contentId=${curCont.contId};nodeId=${curNode.nodeId};objType=${objType};",
    "img":"${curImg}",
    "uc":"${uc_mtsdownload[0]}",
    "mt":"${uc_mtsdownload[1]}",
    "liveList":[
        <c:if test="${objType eq 'live'}">
            <cms:living var="todayLiveCont" nodeid="${curNode.nodeId}" day="0" />
            <c:forEach var="content" items="${todayLiveCont}" varStatus="status">
                {
                    "sTime":"<cms:timeutil time="${content.startTime}" type="1"/>",
                    "eTime":"<cms:timeutil time="${content.endTime}" type="1"/>",
                    "name":"${content.name}",
                },
            </c:forEach>
        </c:if>
    ],
    
    <c:if test="${param.objType eq 'content' || param.objType eq '0' || param.objType eq '1' || param.objType eq '2' || param.objType eq '3' || param.objType eq '4' || param.objType eq 'community'}">
        <c:set var="_sortType" value="desc" />
        <c:if test="${param.objType == '1' }">
            <c:if test="${fn:contains(curNode.fields.property4, 'sortType=asc')}">
                <c:set var="_sortType" value="asc" />
            </c:if>
        </c:if>
        <cms:prevnext nodeid="${curNode.nodeId}" contid="${curCont.contId}" sortType="${_sortType}" />
        <c:if test="${empty prevnext[0]}">
            "preparam":"",
        </c:if>
        <c:if test="${!empty prevnext[0]}">
            <cms:content var="cont" contid="${prevnext[0].contId}" />
            "preparam":"contentId=${prevnext[0].contId};nodeId=${prevnext[0].nodeId};objType=${objType};",
        </c:if>
        <c:if test="${empty prevnext[1]}">
            "nextparam":"",
        </c:if>
        <c:if test="${!empty prevnext[1]}">
            <cms:content var="cont" contid="${prevnext[1].contId}" />
            "nextparam":"contentId=${prevnext[1].contId};nodeId=${prevnext[1].nodeId};objType=${objType};",
        </c:if>
        
        "subList":[
            <c:if test="${param.objType != 'community'}">
                <c:set var="_pageSize" value="100" />
                <c:set var="_sortType" value="desc" />
                <c:if test="${param.objType == '1' }">
                    <c:set var="_pageSize" value="1000" />
                    <c:if test="${fn:contains(curNode.fields.property4, 'sortType=asc')}">
                        <c:set var="_sortType" value="asc" />
                    </c:if>
                </c:if>
                <cms:nodecont var="jujiCont" nodeid="${curNode.nodeId}" dataobjectid="2" sortType="${_sortType}" pagesize="${_pageSize}" />
                <c:forEach var="content" items="${jujiCont}" varStatus="status">
                    {
                        "name":"${content.name}",
                        "param":"contentId=${content.contId};nodeId=${curNode.nodeId};objType=${objType};",
                    },
                </c:forEach>
            </c:if>
        ],
        "curDay":"",
        "sTime":"",
        "eTime":"",
        "supportRate":"${rateParam}",
        "matchedRate":"${matchedRate}",
        
    </c:if>
    <c:if test="${objType eq 'live' || objType eq 'review'}">
        "preparam":"",
        "nextparam":"",
        "subList":[],
        <c:set var="curDay" value="${fn:split(curCont.fields.STARTTIME,' ')}" />
        <c:set var="isReview" value="0" />
        <cms:living var="todayLiveCont" nodeid="${curNode.nodeId}" day="0" />
        <c:forEach var="content" items="${todayLiveCont}" varStatus="status">
            <c:if test="${content.id == curCont.contId}">
                <c:set var="reviewStartTime" value="${content.startTime}" />
                <c:set var="reviewEndTime" value="${content.endTime}" />
                <c:set var="isReview" value="1" />
            </c:if>
        </c:forEach>
        <c:if test="${isReview == 0}">
            <cms:living var="todayLiveCont" nodeid="${curNode.nodeId}" day="-1" />
            <c:forEach var="content" items="${todayLiveCont}" varStatus="status">
                <c:if test="${content.id == curCont.contId}">
                    <c:set var="reviewStartTime" value="${content.startTime}" />
                    <c:set var="reviewEndTime" value="${content.endTime}" />
                    <c:set var="isReview" value="1" />
                </c:if>
            </c:forEach>
        </c:if>
        <c:if test="${isReview == 0}">
            <cms:living var="todayLiveCont" nodeid="${curNode.nodeId}" day="-2" />
            <c:forEach var="content" items="${todayLiveCont}" varStatus="status">
                <c:if test="${content.id == curCont.contId}">
                    <c:set var="reviewStartTime" value="${content.startTime}" />
                    <c:set var="reviewEndTime" value="${content.endTime}" />
                </c:if>
            </c:forEach>
        </c:if>
        "curDay":"${curDay[0]}",
        "sTime":"<cms:timeutil time="${reviewStartTime}" type="1"/>",
        "eTime":"<cms:timeutil time="${reviewEndTime}" type="1"/>",
        "supportRate":"${rateParam}",
        "matchedRate":"${matchedRate}",
    </c:if>
}
</c:if>
<c:if test="${resultCode == 12 || resultCode == 13}">
    <c:if test="${param.objType eq 'live' || param.objType eq 'review'}">
        <cms:livingSource var="source" nodeId="${curNodeId}" />
        <cms:contentproduct var="products" nodeid="${curNodeId}" contentid="${source.contId}"/>
    </c:if>
    <c:if test="${param.objType eq 'content' || param.objType eq '0' || param.objType eq '1' || param.objType eq '2' || param.objType eq '3' || param.objType eq '4' || param.objType eq 'community'}">
        <cms:contentproduct var="products" nodeid="${curNodeId}" contentid="${param.contentId}"/>
    </c:if>
{
    <c:if test="${resultCode == 12}">
        "appointment":"false",
    </c:if>
    <c:if test="${resultCode == 13}">
        "appointment":"true",
    </c:if>
    "orderList":[

    <%//封闭渠道号标记，1为封闭渠道，0为主渠道%>
    <c:set var="channelFlag" value="0" />
    <cms:channelNode />                                  <%//取渠道对应的节点，如渠道关闭返回空%>
    <c:set var="clientChannelNode" value="${channelNode}" />
    <c:if test="${!empty clientChannelId && !empty clientChannelNode && clientChannelNode!='' }">
        <c:set var="channelLinks" value="${fn:split(clientChannelId,'-')}" />
        <c:if test="${!empty channelLinks[1] && channelLinks[1] != '99000'}">
            <c:set var="channelFlag" value="1" />
        </c:if>
    </c:if>

    <c:set var="ordertype" value="all" />
    <c:if test="${channelFlag == 1}" >
        <cms:node var="supposeNode" nodeid="${channelNode}" />
        <c:if test="${fn:contains(supposeNode.fields.property4,'nodeId')}">
            <c:set var="nodelink" value="${fn:split(supposeNode.fields.property4,'=')}" />
            <c:set var="clientChannelNode" value="${nodelink[1]}" />
        </c:if>
        <cms:node var="curNode" nodeid="${clientChannelNode}" />
        <c:if test="${!empty curNode.fields.property3}">
            <c:set var="ordertypeTemp" value="${fn:split(curNode.fields.property3,'=')}" />
            <c:set var="ordertype" value="${ordertypeTemp[1]}" />
        </c:if>
    </c:if>
    <c:forEach var="product" items="${products}" varStatus="status">
        <c:if test="${product.chargeMode=='1' && (ordertype== 'all' || ordertype == 'anci') && (param.objType eq 'content' || param.objType eq '0' || param.objType eq '1' || param.objType eq '2' || param.objType eq '3' || param.objType eq '4' || param.objType eq 'community')}" ><%//内容按次%>
            <cms:filmTickets />
            <c:if test="${!empty product.pdesc}">
                <c:set var="desc" value="${product.pdesc}" />
            </c:if>
            <c:if test="${empty product.pdesc}">
                <c:set var="desc" value="${product.description}" />
            </c:if>
            <c:if test="${filmTickets.status == 'true' && filmTickets.usableFilmTicketValue >= product.price }">
                <c:set var="desc" value="${desc}（您的电影券余额${filmTickets.usableFilmTicketValue/100}元，优先抵扣）" />
            </c:if>
            {
                "secret":"ys=${product.ys};tt=${tt}",
                "typeName":"anci",
                "title":"按次: ${product.price/100}元/次",
                "contparam":"contentId=${param.contentId};nodeId=${curNodeId};productId=${product.productID};",
                "desc":"${desc}"
            },
        </c:if>
    </c:forEach>
    <c:forEach var="product" items="${products}" varStatus="status">
        <c:if test="${product.chargeMode=='0' && (ordertype == 'all' || ordertype == 'month') }"><%//小包月%>
            <c:set var="chuizhiProductIds" value="2028593134;2028593128;2028593136;2028593130;2028593160;2028593158;2028593132;2028593162;2028593340;2028593336;2028593350;2028593345" /><%//垂直栏目产品ID%>
            <c:set var="chuizhiProductIdArray" value="${fn:split(chuizhiProductIds,';')}" />
            <c:set var="isChuizhi" value="0" />
            <c:forEach var="oneChuizhiProductId" items="${chuizhiProductIdArray}">
                <c:if test="${product.productID == oneChuizhiProductId}">
                    <c:set var="isChuizhi" value="0" />
                </c:if>
            </c:forEach>
            <c:if test="${isChuizhi == '0'}">
                <%//正常产品%>
                <c:if test="${product.freetype == '0'}">
                    <c:if test="${!empty product.pdesc}">
                        <c:set var="desc" value="${product.pdesc}" />
                    </c:if>
                    <c:if test="${empty product.pdesc}">
                        <c:set var="desc" value="${product.description}" />
                    </c:if>
                    <c:set var="pName" value="包月: ${product.price/100}元/月" />
                </c:if>
                <%//新产品%>
                <c:if test="${product.freetype == '1'}">
                    <cms:timeCompare var="time1" time1="${now}" time2="${product.freeStartTime}"/>
                    <cms:timeCompare var="time2" time1="${now}" time2="${product.freeEndTime}"/>
                    <c:if test="${time1 == 1 && time2 == 0}">
                        <c:set var="desc" value="${product.freeDesc}" />
                        <c:set var="pName" value="包月: ${product.price/100}元/月-新产品推广" />
                    </c:if>
                    <c:if test="${time1 != 1 || time2 != 0}">
                        <c:if test="${!empty product.pdesc}">
                            <c:set var="desc" value="${product.pdesc}" />
                        </c:if>
                        <c:if test="${empty product.pdesc}">
                            <c:set var="desc" value="${product.description}" />
                        </c:if>
                        <c:set var="pName" value="包月: ${product.price/100}元/月" />
                    </c:if>
                </c:if>
                <%//初次订购%>
                <c:if test="${experienceStatus == 1 && product.freetype == '2'}">
                    <cms:timeCompare var="time1" time1="${now}" time2="${product.freeStartTime}"/>
                    <cms:timeCompare var="time2" time1="${now}" time2="${product.freeEndTime}"/>
                    <c:if test="${time1 == 1 && time2 == 0}">
                        <c:set var="desc" value="${product.firstDesc}" />
                        <c:set var="pName" value="包月: ${product.price/100}元/月-初次体验" />
                    </c:if>
                    <c:if test="${time1 != 1 || time2 != 0}">
                        <c:if test="${!empty product.pdesc}">
                            <c:set var="desc" value="${product.pdesc}" />
                        </c:if>
                        <c:if test="${empty product.pdesc}">
                            <c:set var="desc" value="${product.description}" />
                        </c:if>
                        <c:set var="pName" value="包月: ${product.price/100}元/月" />
                    </c:if>
                </c:if>
                <c:if test="${experienceStatus != 1 && product.freetype == '2'}">
                    <c:if test="${!empty product.pdesc}">
                        <c:set var="desc" value="${product.pdesc}" />
                    </c:if>
                    <c:if test="${empty product.pdesc}">
                        <c:set var="desc" value="${product.description}" />
                    </c:if>
                    <c:set var="pName" value="包月: ${product.price/100}元/月" />
                </c:if>
                {
                    "secret":"ys=${product.ys};tt=${tt}",
                    "typeName":"xiaobaoyue",
                    "title":"${pName}",
                    "contparam":"contentId=${param.contentId};nodeId=${curNodeId};productId=${product.productID};",
                    "desc":"${desc}"
                },
            </c:if>
        </c:if>
    </c:forEach>
    <c:forEach var="product" items="${products}" varStatus="status">
        <c:if test="${product.chargeMode=='15' && channelFlag != 1 && !fn:startsWith(fn:substring(clientChannelId, fn:length(clientChannelId) - 15, fn:length(clientChannelId)), '30')}"><%//大包月%>
            <c:if test="${!empty product.pdesc}">
                <c:set var="desc" value="${product.pdesc}" />
            </c:if>
            <c:if test="${empty product.pdesc}">
                <c:set var="desc" value="${product.description}" />
            </c:if>
            {
                "secret":"ys=${product.ys};tt=${tt}",
                "typeName":"dabaoyue",
                "title":"优惠套餐: 15.00元/月",
                "contparam":"contentId=${param.contentId};nodeId=${curNodeId};productId=${product.productID};",
                "desc":"${desc}"
            },
        </c:if>
    </c:forEach>
    ]
}
</c:if>

<c:if test="${resultCode != 0 && resultCode != 12 && resultCode != 13 && resultCode != 1014}">
{
    <c:if test="${empty param.nodeId}">
    "errordesc":"nodeId为空",
    </c:if>
    <c:if test="${empty param.contentId}">
    "errordesc":"contentId为空",
    </c:if>
    <c:if test="${empty param.objType}">
    "errordesc":"objType为空",
    </c:if>
    <c:if test="${empty param.rate}">
    "errordesc":"param rate为空",
    </c:if>
    <c:if test="${resultCode == 1}">
    "errordesc":"nodeid参数错误",
    </c:if>
    <c:if test="${resultCode == 2}">
    "errordesc":"contid或liveid参数错误",
    </c:if>
    <c:if test="${resultCode == 3}">
    "errordesc":"内容不存在",
    </c:if>
    <c:if test="${resultCode == 4}">
    "errordesc":"节目单不存在",
    </c:if>
    <c:if test="${resultCode == 5}">
    "errordesc":"产品不存在",
    </c:if>
    <c:if test="${resultCode == 6}">
    "errordesc":"直播源不存在",
    </c:if>
    <c:if test="${resultCode == 11}">
    "errordesc":"AAA连接失败",
    </c:if>
    <c:if test="${resultCode == 99}">
    "errordesc":"其他错误",
    </c:if>
    <c:if test="${resultCode == 101}">
    "errordesc":"内容参数为空",
    </c:if>
    <c:if test="${resultCode == 102}">
    "errordesc":"栏目参数为空",
    </c:if>
    <c:if test="${resultCode == 103}">
    "errordesc":"类型参数为空",
    </c:if>
    <c:if test="${resultCode == 104}">
    "errordesc":"节目单无正在播放节目",
    </c:if>
    <c:if test="${resultCode == 105}">
    "errordesc":"模板地址输入错误",
    </c:if>
    <c:if test="${resultCode == 106}">
    "errordesc":"下载返回失败，鉴权返回成功，服务端鉴权出错",
    </c:if>
}
</c:if>
