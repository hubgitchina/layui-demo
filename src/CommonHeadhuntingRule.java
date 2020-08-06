package com.xxx.core.easyrules;

import java.math.BigDecimal;

import org.jeasy.rules.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: CommonHeadhuntingRule
 * @Description: 普通猎头付款规则
 * @Author wangpeng
 * @Date 2020-07-06 14:31
 * @Version 1.0
 */
@Rule(name = "普通猎头", description = "普通猎头首款尾款对半分")
public class CommonHeadhuntingRule {

	private static final Logger log = LoggerFactory.getLogger(CommonHeadhuntingRule.class);

	/**
	 * @Author wangpeng
	 * @Description 条件判断注解：如果return true， 执行Action
	 * @Date 16:16
	 * @Param
	 * @return
	 */
	@Condition
	public boolean isCommonHeadhunting(@Fact("MoneyVo") MoneyVo moneyVo) {

		return moneyVo.getBusinessType() == 0;
	}

	/**
	 * @Author wangpeng
	 * @Description 执行方法注解
	 * @Date 16:17
	 * @Param
	 * @return
	 */
	@Action
	public void commonHeadhuntingAction(@Fact("MoneyVo") MoneyVo moneyVo) {

		log.info("进入普通猎头业务规则");

		BigDecimal chargeAmount = moneyVo.getChargeAmount();
		BigDecimal monthSalary = moneyVo.getMonthSalary();
		BigDecimal rate = moneyVo.getRate().movePointLeft(2);
		BigDecimal taxRate = moneyVo.getTaxRate().movePointLeft(2);
		BigDecimal scaleDivide = new BigDecimal("2");

		/** 首款（付款）= 尾款 = 猎头收费金额/2 */
		BigDecimal firstPay = chargeAmount.divide(scaleDivide, 2, BigDecimal.ROUND_HALF_UP);

		BigDecimal totalPayInvoice = monthSalary.multiply(new BigDecimal("12"))
				.multiply(new BigDecimal("0.01").add(rate));

		BigDecimal firstPayInvoice = totalPayInvoice.divide(scaleDivide, 2,
				BigDecimal.ROUND_HALF_UP);

		BigDecimal afterTaxIncome = totalPayInvoice.divide(new BigDecimal("1.06"), 2,
				BigDecimal.ROUND_HALF_UP);

		BigDecimal afterTaxCost = chargeAmount.divide(new BigDecimal("1").add(taxRate), 2,
				BigDecimal.ROUND_HALF_UP);

		BigDecimal grossProfit = afterTaxIncome.subtract(afterTaxCost);

		moneyVo.setFirstPay(firstPay);
		moneyVo.setEndPay(firstPay);
		moneyVo.setFirstPayInvoice(firstPayInvoice);
		moneyVo.setEndPayInvoice(firstPayInvoice);
		moneyVo.setAfterTaxIncome(afterTaxIncome);
		moneyVo.setAfterTaxCost(afterTaxCost);
		moneyVo.setGrossProfit(grossProfit);
	}

	/**
	 * @Author wangpeng
	 * @Description 优先级注解：return 数值越小，优先级越高
	 * @Date 16:16
	 * @Param
	 * @return
	 */
	@Priority
	public int getPriority() {

		return 0;
	}
}
