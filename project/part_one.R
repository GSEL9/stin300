source('~/Desktop/stin300/project/io.R')
source('~/Desktop/stin300/project/utils.R')

library(gtools)

# PART 1
#
# Reading and formatting of data.
#
path_to_file <- '~/Desktop/stin300/data/Neuraminidase.fasta'
# Load the file and store the data in a table. 
fasta.table <- ReadFasta(path_to_file)
# Add serotype informatino.
fasta.table <- PrepFasta(fasta.table)
#print(fasta.table)

#
# N-type frequency visualization.
#
# Plotting the frequency of each N-type.
#jpeg('./figures/n_type_freq.jpg')
fig <- ggplot(fasta.table) + geom_bar(
  aes(x=factor(N.type, levels=mixedsort(unique(N.type)))), 
  fill='steelblue'
)
fig <- fig + coord_flip() + labs(x='N-type', y='Count')
print(fig)
#dev.off()

# # H-type and N-type associations. Plotting the frequency of each H-type 
# relative to each N-type.
#jpeg('./figures/seroptype_freq.jpg', width=1000, height=1000)
fig <- ggplot(fasta.table) + geom_bar(
  aes(x=factor(Serotype, levels=mixedsort(unique(Serotype)))), 
  fill='steelblue'
)
fig <- fig + coord_flip() + labs(x='Serotype', y='Count')
print(fig)
#dev.off()
