package com.xxx.core.easyrules;

import java.math.BigDecimal;

public class MoneyVo {

	private Integer businessType;

	/**
	 * 猎头收费金额
	 */
	private BigDecimal chargeAmount;

	/**
	 * 费率
	 */
	private BigDecimal rate;

	/**
	 * 税率
	 */
	private BigDecimal taxRate;

	/**
	 * 月薪
	 */
	private BigDecimal monthSalary;

	/**
	 * 首款（付款）
	 */
	private BigDecimal firstPay;

	/**
	 * 尾款（付款）
	 */
	private BigDecimal endPay;

	/**
	 * 首款（开票）
	 */
	private BigDecimal firstPayInvoice;

	/**
	 * 尾款（开票）
	 */
	private BigDecimal endPayInvoice;

	/**
	 * 税后收入
	 */
	private BigDecimal afterTaxIncome;

	/**
	 * 税后成本
	 */
	private BigDecimal afterTaxCost;

	/**
	 * 毛利润
	 */
	private BigDecimal grossProfit;

	public Integer getBusinessType() {

		return businessType;
	}

	public void setBusinessType(Integer businessType) {

		this.businessType = businessType;
	}

	public BigDecimal getChargeAmount() {

		return chargeAmount;
	}

	public void setChargeAmount(BigDecimal chargeAmount) {

		this.chargeAmount = chargeAmount;
	}

	public BigDecimal getRate() {

		return rate;
	}

	public void setRate(BigDecimal rate) {

		this.rate = rate;
	}

	public BigDecimal getTaxRate() {

		return taxRate;
	}

	public void setTaxRate(BigDecimal taxRate) {

		this.taxRate = taxRate;
	}

	public BigDecimal getMonthSalary() {

		return monthSalary;
	}

	public void setMonthSalary(BigDecimal monthSalary) {

		this.monthSalary = monthSalary;
	}

	public BigDecimal getFirstPay() {

		return firstPay;
	}

	public void setFirstPay(BigDecimal firstPay) {

		this.firstPay = firstPay;
	}

	public BigDecimal getEndPay() {

		return endPay;
	}

	public void setEndPay(BigDecimal endPay) {

		this.endPay = endPay;
	}

	public BigDecimal getFirstPayInvoice() {

		return firstPayInvoice;
	}

	public void setFirstPayInvoice(BigDecimal firstPayInvoice) {

		this.firstPayInvoice = firstPayInvoice;
	}

	public BigDecimal getEndPayInvoice() {

		return endPayInvoice;
	}

	public void setEndPayInvoice(BigDecimal endPayInvoice) {

		this.endPayInvoice = endPayInvoice;
	}

	public BigDecimal getAfterTaxIncome() {

		return afterTaxIncome;
	}

	public void setAfterTaxIncome(BigDecimal afterTaxIncome) {

		this.afterTaxIncome = afterTaxIncome;
	}

	public BigDecimal getAfterTaxCost() {

		return afterTaxCost;
	}

	public void setAfterTaxCost(BigDecimal afterTaxCost) {

		this.afterTaxCost = afterTaxCost;
	}

	public BigDecimal getGrossProfit() {

		return grossProfit;
	}

	public void setGrossProfit(BigDecimal grossProfit) {

		this.grossProfit = grossProfit;
	}
}