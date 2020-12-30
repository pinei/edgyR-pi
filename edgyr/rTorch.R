Sys.setenv(MAKE = "make --jobs=4")
install.packages("rTorch", quiet = TRUE)

reticulate::py_discover_config()

# https://f0nzie.github.io/rtorch-minimal-book/pytorch-and-numpy.html

library(rTorch)

transforms  <- torchvision$transforms

# this is the folder where the datasets will be downloaded
local_folder <- '~/Installers/R/datasets/mnist_digits'

train_dataset = torchvision$datasets$MNIST(root = local_folder, 
                                           train = TRUE, 
                                           transform = transforms$ToTensor(),
                                           download = TRUE)

train_dataset

test_dataset = torchvision$datasets$MNIST(root = local_folder,
                                          train = FALSE, 
                                          transform = transforms$ToTensor())
test_dataset
