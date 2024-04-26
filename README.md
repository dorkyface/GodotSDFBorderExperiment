# GodotSDFBorderExperiment
A small project where I used a shader to draw borders around objects that can merge with one another, in the Godot game engine.

![Example Picture 1](https://github.com/dorkyface/GodotSDFBorderExperiment/assets/69087850/c09e2364-2aef-4770-b113-32c5f1d73442)

Link to video:
https://youtu.be/rwbW-Fq7_n8

I have had an idea for a long time for creating a strategy game similar to Civilization V, but instead of being on a grid you could place buildings around your city and have the borders organically grow around them.

This project is just an experiment to see if I could get that effect working. I created a shader that draws SDF circles around custom nodes onto a plane mesh. These custom nodes can be attached to just about any object, and the terrain script can be attached to any Node3D. Each node can have a custom radius defined for it, and there are shader parameters that change things like the color that's drawn. The borders dynamically merge and blend with one another in real-time. This project ended up being a lot more difficult than expected (at least for someone with a passing understanding of shaders and SDFs). 

Huge thanks goes to Igino Quilez, who seems to be the the internet god of SDf shaders. I'd also like to thank clepirelli, whose shader on shadertoy helped me crack one of the hardest challenges I had while working on this shader.

Igino Quilez's website:
https://iquilezles.org/articles/smin/

clepirelli's shader:
https://www.shadertoy.com/view/3t23DG
