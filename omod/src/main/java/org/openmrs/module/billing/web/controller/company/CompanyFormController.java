/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.billing.web.controller.company;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.BillingConstants;
import org.openmrs.module.hospitalcore.BillingService;
import org.openmrs.module.hospitalcore.model.Company;
import org.springframework.beans.propertyeditors.CustomBooleanEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 */
@Controller
@RequestMapping("/module/billing/company.form")
public class CompanyFormController {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(java.lang.Boolean.class, new CustomBooleanEditor("true",
		        "false", true));
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String firstView(@ModelAttribute("company") Company company, @RequestParam(value="companyId",required=false) Integer id, Model model) {
		if( id != null ){
			company = Context.getService(BillingService.class).getCompanyById(id);
			model.addAttribute(company);
		}
		return "/module/billing/company/form";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String onSubmit(Company company, BindingResult bindingResult, HttpServletRequest request) {
		
		new CompanyValidator().validate(company, bindingResult);
		if (bindingResult.hasErrors()) {
			return "/module/billing/company/form";
		}
		BillingService billingService = Context.getService(BillingService.class);
		if( company.getRetired()){
			company.setRetiredDate(new Date());
		}else{
			company.setCreatedDate(new Date());
		}
		billingService.saveCompany(company);
		return "redirect:/module/billing/company.list";
	}
	
}
