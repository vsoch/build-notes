CC = g++
CFLAGS = -Wall -fno-rtti -Os -fdata-sections -ffunction-sections # -Wall -O2
TARGET = car
 
all: $(TARGET).stripped

$(TARGET).stripped: $(TARGET)
	strip -o $(TARGET).stripped $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) -Wl,-O,-s,--gc-sections $(TARGET).o -o $(TARGET)
 
$(TARGET).o: $(TARGET).cpp
	$(CC) $(CFLAGS) -c $(TARGET).cpp -o $(TARGET).o

clean:
	$(RM) $(TARGET) $(TARGET).stripped $(TARGET).o
