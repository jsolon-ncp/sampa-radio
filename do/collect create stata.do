collect clear
        . sysuse auto
        . collect create nointeraction
        . collect: regress mpg price i.foreign
        . collect create interaction
        . collect get: regress mpg price i.foreign##c.trunk
