L = 160 * membrane(1, 100);
f = figure('Position', [100, 100, 600, 400]);  % Figure size
ax = axes('Position', [0.05, 0.1, 0.9, 0.85]);  % Adjust axes position to occupy more space

% Base color defined
baseColor = [0.29 0.61 0.83];
lightColor = [0.6, 0.85, 1];  % Lighter shade of blue

s = surface(L);
s.EdgeColor = 'none';
view(3)

ax.XLim = [1 201];
ax.YLim = [1 201];
ax.ZLim = [-53.4 160];

ax.CameraPosition = [-145.5 -229.7 283.6];
ax.CameraTarget = [77.4 60.2 63.9];
ax.CameraUpVector = [0 0 1];
ax.CameraViewAngle = 36.7;

ax.DataAspectRatio = [1 1 .9];

l1 = light;
l1.Position = [160 400 80];
l1.Style = 'local';
l1.Color = baseColor;  % Use base color for the light

l2 = light;
l2.Position = [.5 -1 .4];
l2.Color = [0.47 0.82 0.93];

s.FaceColor = baseColor;  % Initial face color

s.FaceLighting = 'gouraud';
s.AmbientStrength = 0.3;
s.DiffuseStrength = 0.6;
s.BackFaceLighting = 'lit';

s.SpecularStrength = 1;
s.SpecularColorReflectance = 1;
s.SpecularExponent = 7;

axis off
f.Color = 'white';

% Adjusted text position and size
text(101, 101, 200, 'matlab at unc', 'Color', 'black', 'FontSize', 20, ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

% Create a movie of the rotating surface plot
nFrames = 360;  % number of frames for full rotation
movieFileName = 'surface_rotation_movie.avi';  % movie file name
v = VideoWriter(movieFileName);  % create video writer object
open(v);

for k = 1:nFrames
    % Rotate the view by updating the azimuth angle
    az = az + 5;
    view(az, 30);  % Change azimuth, keeping elevation at 30 degrees

    % Calculate the transition factor
    t = mod(k, nFrames / 2) / (nFrames / 2);  % Normalize to [0, 1] for first half
    if k > nFrames / 2
        t = 1 - t;  % Reverse for the second half
    end

    % Interpolate between the base color and the lighter color
    newColor = (1 - t) * baseColor + t * lightColor;  % Transition to lighter blue
    s.FaceColor = newColor;  % Update surface color

    % Capture the current frame
    frame = getframe(f);
    
    % Write the frame to the video
    writeVideo(v, frame);
end

% Close the video writer object
close(v);

disp('Movie saved successfully.');
