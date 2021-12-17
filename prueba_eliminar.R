


data %>% 
  ggplot(aes(x = tipo,
             y = edad)) +
  geom_boxplot(fill = c("#3EB595","#696969","#FFF447")) +
  labs(y = "Edad",
       x = "") +
  guides(fill=FALSE) +
  theme_minimal() +
  geom_jitter(color="black", size=0.3, alpha=0.2) 