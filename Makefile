################################################################################
#
# Author: Paraita Wohler <paraita.wohler@gmail.com>
#
################################################################################

# libs TODO modifier selon l'architecture
BOOST_INC := -I/opt/local/include
BOOST_LIB := -L/opt/local/lib -lboost_system-mt -lboost_filesystem-mt -lboost_thread-mt
TBB_LIB   := -ltbb

# arborescence
SRCDIR  := src
BINDIR  := bin
OBJDIR  := obj
RESDIR  := res

# compilers
CC := clang++ -c
LINK := clang++

# targets
EXECUTABLE := hftsim
SRC := Exceptions.cpp Order.cpp OrderBook.cpp Agent.cpp \
	   NewsServer.cpp Market.cpp LiquidityProvider.cpp \
	   NoiseTrader.cpp MarketMaker.cpp Plot.cpp Stats.cpp Simulator.cpp
OBJS := $(SRC:.cpp=.o)
LOBJS := $(patsubst %.o,$(OBJDIR)/%.o,$(OBJS))

# compile and link commands
TARGET := $(BINDIR)/$(EXECUTABLE)
LINKLINE := $(LINK) -o $(TARGET) $(LOBJS)

################################################################################
# General Rules
################################################################################
%.o : $(SRCDIR)/%.cpp
	$(CC) $(CFLAGS) -o $(OBJDIR)/$@ -c $< $(BOOST_INC)

# user targets
all: arch-cible $(TARGET)
	@echo "Finished OK"

arch-cible:
	@echo "compilation on arch $(shell uname)"

$(TARGET): makedirs $(OBJS)
	$(LINKLINE) $(BOOST_INC) $(BOOST_LIB) $(TBB_LIB)

makedirs:
	@mkdir -p $(OBJDIR)
	@mkdir -p $(BINDIR)
	@mkdir -p $(RESDIR)

clean:
	@echo "uoti, ma ro'a !"
	-@rm -Rf $(OBJDIR) $(BINDIR) $(RESDIR) *.data

.PHONY: clean mrproper check-syntax $(TARGET) $(BINDIR) $(SRCDIR) $(OBJDIR)
