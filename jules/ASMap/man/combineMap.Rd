\name{combineMap}
\alias{combineMap}
\title{
Combine linkage maps from multiple R/qtl cross objects
}
\description{
Combine map information and marker data for linkage maps from multiple R/qtl cross objects
}
\usage{
combineMap(..., id = "Genotype", keep.all = TRUE)
}
\arguments{
  \item{\ldots}{
An unlimited set of arguments with each argument defining an R/qtl cross
object. All R/qtl objects can have any class structure but it must be
identical across objects. (see Details for more information.)
}
\item{id}{
The name of the common column in the \code{pheno} element of each cross
object representing the genotype names. Default is \code{"Genotype"}.
}
\item{keep.all}{
A logical value determining whether all genotypes should be kept in the
final linkage map regardless of their absence in some linkage maps (see
Details). Default is \code{TRUE}.
}
}
\details{
This function combines linkage maps from multiple R/qtl cross
objects by merging marker data and map information. The function
contains some initial checks before proceeding with the
combining. Firstly, all R/qtl cross objects must have the same class
structure and have a column in the \code{pheno}
element of the object named by the argument \code{id}. The marker
names must also be unique across linkage maps as well as avoid the
symbol ";". This symbol is reserved for string manipulation within the
function.

The combining of linkage maps occurs in multiple ways. Firstly, it merges the linkage maps
sequentially based on genotype names. If \code{keep.all=TRUE} then the
marker data is "padded out" when genotype names are not shared between
maps. If \code{keep.all=FALSE} then the marker data is shrunk to only
include genotypes that are shared among all linkage maps. Secondly, if a
linkage group name is shared across linkage maps then the marker data from the
shared linkage group in each of the maps will be merged.

Several things are important to note with this function. Non-matching
genotype names between linkage maps will expand the final marker data so
it is prudent to check genotype names are correct in each of the linkage
maps before combining. If linkage groups between maps share the same
name and do not require merging then only unique linkage group names should exist across the
set of linkage maps. As a final process, markers are ordered within
linkage groups according to distances supplied in each of the linkage
maps.

It should also be noted that this function does not re-construct the
final linkage map after combining the set of linkage maps. For efficient linkage map
reconstruction of the combined R/qtl linkage map see
\code{mstmap.cross()}.
}
\value{
A single R/qtl cross object is returned with identical class structure as the
inputted cross objects.
}
\author{
Julian Taylor
}
\seealso{
\code{\link{breakCross}} and \code{\link{mergeCross}}
}
\examples{

data(exmap, package = "ASMap")

## create copy of exmap with some different linkage groups
## and change marker names so they are unique

exmap1 <- exmap
names(exmap1$geno)[5:14] <- paste("L",1:10, sep = "")
exmap1$geno <- lapply(exmap1$geno, function(el){
    names(el$map) <- dimnames(el$data)[[2]] <- paste(names(el$map), "A", sep = "")
    el})

exmapf <- combineMap(exmap, exmap1)
nmar(exmapf)
}
\keyword{misc}