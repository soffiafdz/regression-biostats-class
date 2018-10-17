#Ex 11.2

#The data in the table (Everitt and Rabe-Hesketh, 2001) are the survival times (in months) after mastectomy of women with breast cancer. The cancers are classified as having metastasised or not based on a histochemical marker. Censoring is indicated by the event variable being TRUE in case of death. Plot the survivor functions of each group, estimated using the Kaplan-Meier estimate, on the same graph and comment on the differences. Use a log-rank test to compare the survival experience of each group more formally. 

HSAUR::mastectomy

g3


layout(matrix(1:2, ncol = 2))

g3 <- subset(glioma, histology == "Grade3")
plot(survfit(Surv(time, event) ~ group, data = g3), main = "Grade III Glioma", lty = c(2,1), ylab="Probability", xlab="Survival Time in Month", legend.bty = "n", legend.text = c("Control", "Treated"))

g4 <- subset(glioma, histology == "GBM")
plot(survfit(Surv(time, event) ~ group, data = g4),
     main = "Grade IV Glioma", 
     ylab = "Probability",
     lty = c(2,1),
     xlab = "Survival time in Month",
     xlim = c(0, max(glioma$time) * 1.05))


survdiff(Surv(time, event) ~ group, data = g3)


logrank_test(Surv(time, event) ~ group, data = g3, distribution = "exact")


survdiff(Surv(time, event) ~ group, data = g4)


logrank_test(Surv(time, event) ~ group, data = g4, distribution = "exact")


logrank_test(Surv(time, event) ~ group | histology, data = glioma, distribution = approximate(B = 10000))

data("GBSG2", package = "TH.data")


GBSG2_coxph <- coxph(Surv(time, cens) ~ ., data = GBSG2)
ci <- confint(GBSG2_coxph)
exp(cbind(coef(GBSG2_coxph), ci))['horThyes',]

GBSG2_zph <- cox.zph(GBSG2_coxph)

logrank_test(Surv(time, event) ~ group | histology, data = glioma, distribution = approximate(B = 10000))
(Surv(time, event) ~ metastized, data = mastectomy)


ggsurvplot(
    survfit(Surv(time, event) ~ group, data = g4), 
    data = g4, 
    size = 0.5,                 # change line size
    linetype = c("dashed", "solid"), # different line type
    palette = c("red","blue"), # color red, blue or custom palettes lancet
    title   = "Grade IV Glioma", # plot main title
    xlab = "Survival in Months", # customize X axis label.
    conf.int = TRUE,          # Add confidence interval
    pval = TRUE,              # Add p-value from log-rank test
    risk.table = TRUE,        # Add risk table
    risk.table.col = "strata",# Risk table color by groups
    legend.labs = c("Control","RIT"),    # Change legend labels
    risk.table.height = 0.25, # Useful to change when you have multiple groups
    surv.median.line = "hv",  # add the median survival pointer.
    ggtheme = theme_bw()      # Change ggplot2 theme



as.tibble(mastectomy)
########################

survfit(Surv(time, event) ~ metastized, data = mastectomy)

ggsurvplot(
    survfit(Surv(time, event) ~ metastized, data = mastectomy), 
    data = mastectomy, 
    size = 0.7,
    linetype = c("dashed", "dotted"),
    title   = "Mastectomy",
    xlab = "Months after mastectomy", 
    conf.int = TRUE,
    pval = TRUE,    
    risk.table = TRUE,
    risk.table.col = "strata",
    legend.labs = c("No metastized","Metastized"),
    surv.median.line = "hv",
    ggtheme = theme_minimal()
)

logrank_test(Surv(time, event) ~ metastized, data = mastectomy, distribution = "exact")
