
.data BR32
.rw r0-r7

.code @0
mov 10000, r1 ; 0x1 2710 1
mov 10000, r2 ; 0x1 2710 2
mov 10000, r3 ; 0x1 2710 3
mov 9000, r4 ; 0x1 2328 4
mov 800, r5 ; 0x1 320 5
mov 40, r6 ; 0x1 28 6
mov 1, r7 ; 0x1 1 7
add r1, r2, r0 ; 0x0 1 2 0
add r0, r3, r0 ; 0x0 0 3 0
add r0, r4, r0 ; 0x0 0 4 0
add r0, r5, r0 ; 0x0 0 5 0
add r0, r6, r0 ; 0x0 0 6 0
add r0, r7, r0 ; 0x0 0 7 0