# GodotSDFBorderExperiment
A small project where I used a shader to draw borders around objects that can merge with one another, in the Godot game engine.

![0001-0320](https://github.com/dorkyface/GodotSDFBorderExperiment/assets/69087850/7ba9d6f5-eabc-4e4f-a024-693f189f65c4)

I have had an idea for a long time for creating a strategy game similar to Civilization V, but instead of being on a grid you could place buildings around your city and have the borders organically grow around them.

This project is just an experiment to see if I could get that effect working. I created a shader that draws SDF circles around custom nodes onto a plane mesh. Any objects with a BorderNode attached to it will have the border drawn around them in real-time. Each of these BorderNodes has an exported "Radius" variable to change how large or small an area the border will be drawn around the object. These custom nodes can be attached to just about any object, and the terrain script can be attached to any Node3D.

![BorderNode](https://github.com/dorkyface/GodotSDFBorderExperiment/assets/69087850/49fcd8b8-863f-4151-87cc-3f940556cd49)

Shader Parameters:
- Smooth Minimum Blend: Changes how much the borders / lines blend into one another. At 0.0, there's no blending.
- Border Color: Changes what the color of the lines drawn around objects is
- Border Alpha: Changes the transparancy of the border lines. Ranges from 0.0 to 1.0
- Map Color: Changes the color of the rest of the plane mesh
- Map Alpha: Changes the transparency of the rest of the plane mesh

*The parameters "scale offset" and "positions" should not be touched.* They're exposed so that they can be modified via script.

![Shader Parameters](https://github.com/dorkyface/GodotSDFBorderExperiment/assets/69087850/429837a2-e629-4b83-ae9d-7d73d0aef2d7)

![CustomColors](https://github.com/dorkyface/GodotSDFBorderExperiment/assets/69087850/464b917b-98c7-42f2-beaa-09dc019029f2)

This project ended up being a lot more difficult than expected (at least for someone with a passing understanding of shaders and SDFs).Huge thanks goes to Igino Quilez, who seems to be the the internet god of SDf shaders. I'd also like to thank clepirelli, whose shader on shadertoy was an extremely useful reference while working on this shader. I learned a lot while doing this small project, from understanding how SDFs work to using git properly for the first time.

Igino Quilez's website:
https://iquilezles.org/articles/smin/

clepirelli's shader:
https://www.shadertoy.com/view/3t23DG
