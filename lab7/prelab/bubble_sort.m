LIST = [10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33]; % initialized the list 

n = LIST(1); % get number of elements
sort_list = LIST(2:1+n); % get the rest of the list

swapped = 1; % because we want to create a while loop just like in assembly

while swapped == 1
    swapped = 0; % no more swap then stop
    for i = 1 : (n-1) % since MATLAB start at 1
        % SWAP until we do not SWAP anymore
        [sort_list, flag] = SWAP(sort_list, i);  % attempt to swap A(i) and A(i+1)
        if flag == 1 % if we swap
            swapped = 1; % flad is swap to continue
        end
    end
end

% The list A is now sorted, display the sorted list
disp('Sorted List:');
disp(sort_list);


function [A, flag] = SWAP(A, i)
    flag = 0; % If there is no swap then stay o
    if A(i) > A(i + 1)
        temp = A(i); % assign current value to temp
        A(i) = A(i + 1); % switch with the net value
        A(i + 1) = temp; % assign the temp to current value
        flag = 1; % put flag if we swap
    end
    
end