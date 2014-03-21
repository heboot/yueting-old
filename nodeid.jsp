<%@ page language="java" contentType="text/plain" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String upChannelId = request.getHeader("X_UP_CLIENT_CHANNEL_ID");
request.getSession().setAttribute("channelId", upChannelId);
%>
<%//home==开始%>
    <c:set var="homePanoramaId" value="10161427" /> <%//滚动图片区%>
    <c:set var="homeRecommendId" value="10161426" />
    <c:set var="homeChannelId" value="10161412" />
        
    <c:set var="myorderProductId" value="2028593814" />
<%//home==结束%>
<%//渠道版本add,通知栏目ID设置，根据渠道号码设置对应的栏目ID %>
<%
    java.util.HashMap<String, String> hm_notice = new java.util.HashMap<String, String>();
    hm_notice.put("99000", "10158167");
    hm_notice.put("99001", "10030010");
    hm_notice.put("99002", "10030011");
    hm_notice.put("99003", "10030012");
    hm_notice.put("99020", "10021458");
    hm_notice.put("99013", "52015");
    String nValue = "";
    
    String nChannel = (String)request.getSession().getAttribute("channelId");
    if (nChannel != null && !"".equals(nChannel) )
    {
        String[] nChannels = nChannel.split("-");
        nValue = hm_notice.get(nChannels[1]);
        if (nValue !=null && !"".equals(nValue))
            request.getSession().setAttribute("noticeNodeId", nValue);
        else{
            nValue = hm_notice.get("99000");
            request.getSession().setAttribute("noticeNodeId", nValue);
        }
    }
    else
    {
        nValue = hm_notice.get("99000");
        request.getSession().setAttribute("noticeNodeId", nValue);
    }
%>
<%//widget栏目ID设置，根据渠道号码设置对应的栏目ID %>
<%
    java.util.HashMap<String, String> hm_widget = new java.util.HashMap<String, String>();
    hm_widget.put("99000", "10176992");
    hm_widget.put("99001", "10030010");
    hm_widget.put("99002", "10030011");
    hm_widget.put("99003", "10030012");
    hm_widget.put("99020", "70344");
    hm_widget.put("99013", "52015");
    String wValue = "";
    String wChannel = (String)(request.getSession().getAttribute("channelId"));
    if (wChannel != null && !"".equals(wChannel))
    {
        String[] wChannels = wChannel.split("-");
        wValue = hm_widget.get(wChannels[1]);
        if (wValue !=null && !"".equals(wValue))
            request.getSession().setAttribute("widgetNodeId", wValue);
        else{
            wValue = hm_widget.get("99000");
            request.getSession().setAttribute("widgetNodeId", wValue);
        }
    }
    else
    {
        wValue = hm_widget.get("99000");
        request.getSession().setAttribute("widgetNodeId", wValue);
    }
%>
