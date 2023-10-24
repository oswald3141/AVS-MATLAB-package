function prevent_sleep_mode(state)
% PREVENT_SLEEP_MODE Prevents the machine entering the sleep mode
%
%   PREVENT_SLEEP_MODE("on") marks the MATLAB's thread as requiring the
%   machine to remain active thus preventing it from entering the sleep
%   mode.
%
%   PREVENT_SLEEP_MODE("off") restores the MATLAB's thread execution state
%   to the one allowing the sleep mode.
%
%   The function supports Windows machines only.
%   The function makes a direct call to WinAPI, and therefore requires a
%   compiler supported by MATLAB to be installed. You can call
%       mex -setup C
%   for further details.
%
%   The implementation is copied with small refinements from
%   https://se.mathworks.com/matlabcentral/fileexchange/36194-insomnia-prevent-computer-sleep-mode
%   Credits to Francesco Montorsi

    arguments(Input)
        state {mustBeMember(state, ["on" "off"])}
    end

    assert(ispc, "prevent_sleep_mode:UnsupportedPlatform", ...
        "The implementation for this platform is not available.");

    % Thread's execution requirements for SetThreadExecutionState
    % See http://msdn.microsoft.com/en-us/library/windows/desktop/aa373208(v=vs.85).aspx
    ES_CONTINUOUS = 0x80000000;
    ES_SYSTEM_REQUIRED = 0x00000001;
    ES_AWAYMODE_REQUIRED = 0x00000040;

    if state == "on"
        % Load kernel32 library

        % Header with SetThreadExecutionState prototype
        header_fname = ".\prevent_sleep_mode.h";

        assert(isfile(header_fname), ...
            "prevent_sleep_mode:HeaderFileMissing", ...
            "The header file is missing.");

        addpath(getenv("SYSTEMROOT") + "\system32\");

        if ~libisloaded("kernel32")
            loadlibrary("kernel32", header_fname);

            assert(libisloaded("kernel32"), ...
                "prevent_sleep_mode:Kernel32LoadFailure", ...
                "Error while trying to load kernel32.dll.");
        end

        % Call SetThreadExecutionState to prevent sleep mode

        newExecState = bitor(bitor( ...
            ES_CONTINUOUS, ES_SYSTEM_REQUIRED), ES_AWAYMODE_REQUIRED);

        ret = calllib("kernel32", "SetThreadExecutionState", ...
            newExecState);

        assert(ret ~= 0, ...
            "prevent_sleep_mode:WinApiCallFailure", ...
            "Error while trying to prevent system sleep.");

        fprintf("MATLAB's thread is successfully marked " + ...
            "as requiring the machine to stay awake.\n");
    elseif state == "off"
        assert(libisloaded("kernel32"), ...
            "prevent_sleep_mode:Kernel32IsNotLoaded", ...
            "kernel32 is not loaded.");

        % Restore previous execution state
        ret = calllib("kernel32", "SetThreadExecutionState", ...
            ES_CONTINUOUS);

        assert(ret ~= 0, ...
            "prevent_sleep_mode:WinApiCallFailure", ...
            "Error while trying to restore thread execution state.");

        fprintf("The previous execution state of the MATLAB's " + ...
            "thread is restored successfully.\n");
    end

end
