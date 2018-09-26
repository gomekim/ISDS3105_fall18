library(tidyverse)
library(fivethirtyeight)
fivethirtyeight::drug_use
drug_use2 <- drug_use %>%
  filter(age %in% c('18', '19', '20', '21', '22-23'))
gather(drug_use2, drug, usage, 'alcohol_use', 'marijuana_use', 'cocaine_use') %>%
  ggplot() +
  geom_bar(aes(x = drug, y = usage), stat = 'identity') + facet_wrap(~age)


