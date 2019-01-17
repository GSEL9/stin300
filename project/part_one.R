source('~/Desktop/stin300/project/io.R', local=T)
source('~/Desktop/stin300/project/utils.R', local=T)

# PART1
#
# Reading and formatting of data.
#
path_to_file <- './../data/Neuraminidase.fasta'
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


#
# H-type and N-type associations.
# 
# Are some H-types more often paired with particular N-types?
# Count occurances 
# 
# for each H-type
#   count how often pairs with N-type
# 
n.types <- length(fasta.table$H.type)
M <- matrix(
  0, nrow=n.types, ncol=n.types,
  dimnames=list(fasta.table$H.type, fasta.table$N.type)
)
for (i in 1:n.types) {
  print(table(fasta.table$H.type[i]))
}
