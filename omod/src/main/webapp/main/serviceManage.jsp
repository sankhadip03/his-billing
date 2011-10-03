<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="Manage Bill Services" otherwise="/login.htm" redirect="/module/billing/main.form" />

<%@ include file="/WEB-INF/template/header.jsp" %>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/moduleResources/billing/scripts/jquery/css/checktree.css" />

<!-- jQuery Script & CSS imports -->
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/billing/scripts/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/billing/scripts/jquery/jquery.checktree.0.3b1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/hospitalcore/scripts/jquery/jquery.thickbox.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/moduleResources/hospitalcore/scripts/jquery/css/thickbox.css" />
<c:forEach items="${errors}" var="error">
	<span class="error"><spring:message code="${error.defaultMessage}" text="${error.defaultMessage}"/></span>
</c:forEach>
<form method="POST" id="billMapping"   onsubmit="return false">

<ul class="tree" style="margin-left: 15px;">
${tree}
</ul>
		
<div> <input type="button" id="priceForm" name="subm" value="Save" onclick="submitForm()" /></div>
</form>
	
<script type="text/javascript">
function submitForm()
{
	var valid= true;
	var names;
	jQuery("input[type='checkbox']:checked").each(function(){
		var id= "#"+jQuery(this).val()+"_price";
		if( jQuery(id).length > 0){
			if( !validPrice(jQuery(id).val()) ){
				valid = false;
				names += "\n" +jQuery("#"+jQuery(this).val()+"_name").val();
			}
		}
	});
	if( !valid ){
		alert("Invalid price! \n" + names);
	}else{
		jQuery("#billMapping").submit();
	}
}
function validPrice(value)
{
	return /^[0-9]+(\.[0-9]+)?$/i.test(value) || jQuery.trim(value) == "" ;
}
function updatePrice(this_)
{
	if( ! validPrice( jQuery(this_).val()) )
	{
		alert("Invalid price!");
		jQuery(this_).focus();
		return;
	}
	
	var checkBox = jQuery(this_).parents("li:first").children("div.checkbox:first");
	if( !checkBox.hasClass("checked") ) 
	{
		checkBox.click();
	}
	
}
function removeService(this_,id)
{
	jQuery("#"+id).val("");
	var checkBox = jQuery(this_).parents("li:first").children("div.checkbox:first");
	if( !checkBox.hasClass("checked") ) 
	{
		checkBox.click();
	}
}
jQuery(document).ready(function(){
	jQuery("ul.tree").checkTree();
	});
</script>


<%@ include file="/WEB-INF/template/footer.jsp" %> 