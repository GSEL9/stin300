# Load the data table `tomato_gff` data table.
load(url("http://arken.nmbu.no/~larssn/teach/stin300/tomato_gff.RData"))
# NOTE: 
# * The table contain genomic features in the reference genome of tomato. 
# * Each column represents a feature.

drop.cols <- c('Score', 'Phase')

data <- (
  tomato_gff
  # Remove columns Score and Phase from the table.
  %>% select(-drop.cols)
  # The length of each feature (absolute value of Start minus End plus 1).
  %>% mutate(feat.len=abs(Start - End + 1))
  # Group by each feature type.
  %>% group_by(Type)
  # The number of features for each type, as well as their total char length.
  %>% mutate(num.feats=length(Type), type.len=nchar(Type))
  %>% ungroup(Type)
  %>% mutate(log.feat.len=log(feat.len))
)
fig <- ggplot(data, aes(x=num.feats, y=type.len)) + geom_point(color=Type)
fig <- fig + labs(x='Type length', y='Feature count')
print(fig)
# * Make a plot of the number of features versus total length for each Type, 
#   and map some aesthetic to Type to make it visible which type is which in 
#   the plot.
# * It is probably a good idea to use log-transformed axes (scaling).

data2 <- subset(data, Type=='CDS' & feat.len>=30)

dist.plot <- ggplot(data2)
dist.plot <- dist.plot + geom_histogram(aes(x=data2$feat.len))
print(fig)
