---
toc: 1
---

## Now or Never

### Overview

This paper {% cite winters:ewg20-what-is-abi %} appears to be a document similar to {% cite winters:ewg20-now-or-never %},
The author opens by saying for C++14,17,20 have been ABI stable, and he's been advocating to break it, but is changing his mind. He brings up culture and user expectations - people
expect ABI to be stable, and he doesn't think the list of changes (that he estimates would improve performance 5-10%) that are warranted outweigh
the damage to the ecosystem that would result. He estimates the costs to be "an engineer-millenia."

The author is saying that if ABI is not to be broken, the WG21 should be very
"public about that decision" instead of wishy washy. Conversely, if they decide to break ABI, they need to be principled about it. The author summarizes three options he sees:

1. Decide on when to break ABI (e.g., release C++23/26) and provide a heads up and diagnostic tools.
2. Decide not to break it, and commit to stability.
3. Do nothing, and stay like we are now (wishy washy, at best).

He adds subtext that `2` is boring and safe, and `1` is best for users that want to maximize performance. `3` is really a failure of leadership. He is worried that if we don't break ABI, we leave room for a competitor, more performant language to be created.

<hr>

{% bibliography --cited %}
