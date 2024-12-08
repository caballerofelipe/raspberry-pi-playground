I asked this question on StackExchange:

[pi 4 - How to manage GPIOs on the Raspberry Pi using the command line? And other clarifications](https://raspberrypi.stackexchange.com/questions/149521/how-to-manage-gpios-on-the-raspberry-pi-using-the-command-line-and-other-clarif)

The question wasn't too well received and was locked.

However I did learn a bit about different libraries for GPIO interactions. From my readings I concluded that using `pinctrl` wasn't too safe because it bypassed the kernel drivers so I guess that means I could mess things up if no careful. That's why I decided on keep using `/sys/class/gpio/export`.