---
toc: 1
---

## What is ABI, and What Should WG21 Do About It?

### TLDR

ABI == Application Binary Interface. This (document? email?) seems to be talking
about it in context of WG21, which I can only guess means "Working Group 2021," some
kind of group that reviews changes to C++ that might break ABI (and thus doesn't allow).
This author, however is suggesting that:

{% quote winters:ewg20-now-or-never %}
We should change themangling for C++23 symbols in a way that is not compatible with previous C++manglings.​
{% endquote %}

and changing the manglings so it can be detected at load time via a prefix (e.g., _Z vs _Y). He thinks it's reasonable to break ABI every ~3 years, and force rebuilds. He thinks 
the other alternative (not breaking it) will lose industry involvement. It's interesting that this seems to be a cultural thing - so far the standard has been to not break it,
but there are greater costs to this over time.

### Overview

The idea of ABI compatibility is much simpler than I anticipated. This might be an oversimplifcation, but when we compile the code in C/C++, we have "mangled strings"
that are left behind in the binary to help with linking (this could be more specific).
A nice example from Wikipedia is the following:

```cpp
namespace​ wikipedia {
    ​class​ article ​{
        public​:​
             /* Mangles as: _ZN9wikipedia7article6formatEv */      
             std​::​string​ format​(​void​);
         ​};
    };
```

So if we change the name, arguments, or even template arguments for a function,
that is an ABI change because it changes this "mangled name."

An **ABI Break** is thus when something changes to warrant using a different function
to generate the mangled name, or generating a different mangled name all together.
If two compiled binaries are talking to one another, they have to agree on that name.
The document mentions that it's no different than a binary file format or network protocol
in that sender and receiver have to agree on how to interpret a file.

**Hyrum's Law** says that when you have enough users of an API, all endpoints/behaviors
are going to be depended on by somebody. This is an argument for not breaking ABI because so many depend on it. E.g., the ecosystem (gcc and clang) has used it for 10+ years and changing it would break a lot. But it's also an argument for breaking ABI because it's inevitable.

The author is worried that if we don't break it, industry involvement will decrease,
because not breaking it means too many sacrifices to performance.

#### WG21

The purpose of this group is revealed on page 5:

> ...the behavior of WG21 for several years has been to give standardlibrary implementers an effective veto on any proposal that would break ABI.

Wow, so we need humans to check and manage these changes. Isn't that error prone? 
The author mentions taking an "ABI break" and I'm not clear what that means.
Wouldn't so many things break?

<hr>

{% bibliography --cited %}
