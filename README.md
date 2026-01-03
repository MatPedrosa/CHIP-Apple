# **NOWHERE NEAR DONE YET**
This is my first Git/Github repo, I barely know what I'm doing.

I mean, like, I can code, but my *organizational process*
up until now has just been:
* Create new file
* It's somewhere on my computer
* Done!

Whatever negative statement have you just thought of this process,
oh you *bet*.

As just said above, I can (surprizingly) code. This repo, though, is
definitely one of my worst examples of such.\
✨😘✨\
Everything you see here was cobbled together to **Just Work™,**
leaning heavily so towards the least efficient, or visually pleasing,
code ever written. Yet, somehow, I'm still maintaining it...

# CHIP-Apple
Playing *Bad Apple!!* in stock *CHIP-8*, no extensions,
fully *COSMAC VIP* compatible

# Context, for the uninitialized
Nothing yet :-I (To paraphrase [mitxela](http://mitxela.com),
writing takes effort)\
For now, wikipedia to the rescue! (except, there's no article on
Bad Apple!! specifically... Oh well).

# How does this work?
The only way to draw anything to the screen in CHIP-8 is to use the
**Draw sprite** command:\
`DXYN - Draw sprite at (VX, VY), with height N`\
The screen can also be cleared:\
`00E0 - Clear screen (Hmm, guess you got it...)`

Sprites are, at most, 8x15 pixels, and are always XOR'ed with the
contents of the screen, which is only 64x32 pixels (!)

Because of some weird quirk of the *CHIP-8* interpreter in the
original *COSMAC VIP*, you can only draw **ONE** sprite per frame,
at 60 FPS. (Really, it's specifically coded to draw the sprite, then
wait around until the next frame. For afaik, absolutely no reason)

So, if we wanna play *Bad Apple!!* on this **1977 beast,** we need
to find, for each frame, the best 8x15 region of the screen to update.
Here, it actually helps that the screen is tiny.

TO BE CONTINUED...
