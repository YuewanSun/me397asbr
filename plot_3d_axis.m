function plot_3d_axis(origin, xvec, yvec, zvec, varargin)
    % Plots a red-green-blue, x-y-z axis in 3d figure.
    % Inputs:
    %   origin: 3x1 x,y,z location of axis origin in figure coordinates
    %   xvec: 3x1 direction of the axis +x direction in figure coordinates
    %   yvec: 3x1 direction of the axis +y direction in figure coordinates
    %   zvec: 3x1 direction of the axis +z direction in figure coordinates
    % Jeff Bonyun (jb79332), jbonyun@utexas.edu, 20220215
    % On behalf of the Sun/Bonyun team for ME397 ASBR, Spring 2022.

    p = inputParser;
    isVec3 = @(x) numel(x) == 3 && sum(size(x) == 1) == ndims(x)-1;
    isAxes = @(x) isa(x, 'matlab.graphics.axis.Axes');
    addRequired(p, 'origin', isVec3);
    addRequired(p, 'xvec', isVec3);
    addRequired(p, 'yvec', isVec3);
    addRequired(p, 'zvec', isVec3);
    addOptional(p, 'ax', gca, isAxes);
    addParameter(p, 'Label', nan, @ischar);
    parse(p, origin, xvec, yvec, zvec, varargin{:});
    args = p.Results;

    was_hold = ishold();
    hold on;

    % Plot them separately so that we can control the color individually.
    quiver3(args.ax, origin(1), args.origin(2), args.origin(3), args.xvec(1), args.xvec(2), args.xvec(3), 'r', 'LineWidth', 2, 'MaxHeadSize', 5);
    quiver3(args.ax, origin(1), args.origin(2), args.origin(3), args.yvec(1), args.yvec(2), args.yvec(3), 'g', 'LineWidth', 2, 'MaxHeadSize', 5);
    quiver3(args.ax, origin(1), args.origin(2), args.origin(3), args.zvec(1), args.zvec(2), args.zvec(3), 'b', 'LineWidth', 2, 'MaxHeadSize', 5);
    if ~isnan(args.Label)
        text(origin(1), origin(2), origin(3), args.Label, 'Interpreter', 'latex');
    end

    if ~was_hold
        hold off;
    end
