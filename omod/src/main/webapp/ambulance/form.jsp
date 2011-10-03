<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Add/Edit Ambulance" otherwise="/login.htm" redirect="/module/billing/main.form" />

<%@ include file="/WEB-INF/template/header.jsp" %>
<h2><spring:message code="billing.ambulance.manage"/></h2>

<c:forEach items="${errors.allErrors}" var="error">
	<span class="error"><spring:message code="${error.defaultMessage}" text="${error.defaultMessage}"/></span>
</c:forEach>
<spring:bind path="ambulance">
<c:if test="${not empty  status.errorMessages}">
<div class="error">
<ul>
<c:forEach items="${status.errorMessages}" var="error">
    <li>${error}</li>   
</c:forEach>
</ul>
</div>
</c:if>
</spring:bind>
<form method="post" class="box">
<table>
	<tr>
		<td><spring:message code="general.name"/></td>
		<td>
			<spring:bind path="ambulance.name">
				<input type="text" name="${status.expression}" value="${status.value}" size="35" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td valign="top"><spring:message code="billing.description"/></td>
		<td>
			<spring:bind path="ambulance.description">
				<input type="text" name="${status.expression}" value="${status.value}" size="35" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td><spring:message code="general.retired" /></td>
		<td>
			<spring:bind path="ambulance.retired">
				<openmrs:fieldGen type="java.lang.Boolean" formFieldName="${status.expression}" val="${status.editor.value}" parameters="isNullable=false" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
</table>
<br />
<input type="submit" value="<spring:message code="general.save"/>">
<input type="button" value="<spring:message code="general.cancel"/>" onclick="javascript:window.location.href='ambulance.list'">
</form>
<%@ include file="/WEB-INF/template/footer.jsp" %>