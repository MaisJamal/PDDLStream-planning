(define (domain driving)
    (:requirements :strips :equality)
    (:predicates
        ; Static predicates (predicates that do not change over time)
      	(IsVehicle ?obstacle)
        (IsPedestrian ?obstacle)
        (NeighborLeftLane ?lane2 ?lane1)
        (NeighborRightLane ?lane2 ?lane1)
        (PoseOnLane ?pose ?lane)
        (Motion ?ego ?pose1 ?pose2 ?traj)
        
        (IsTraj ?traj)
        
        ; Fluent predicates (predicates that change over time, which describes the state of the sytem)
    	(AtPose ?object ?pose)
        (OnLane ?ego ?lane)
        (IsClear ?pose)
         
        
        ; Derived predicates (predicates derived from other predicates, defined with streams)
    	(Unsafe ?traj)

        ; External predicates (evaluated by external boolean functions)
      	(Collision ?traj ?obstacle ?pose)
        (AtGoal ?ego ?pose ?goal)
    )
    (:action keeplane
    	:parameters (?ego ?pose ?pose2 ?lane ?traj)
    	:precondition
    		(and (OnLane ?ego ?lane)
    			 (AtPose ?ego ?pose) (IsClear ?pose2)
    			 (not (Unsafe ?traj)))
    	:effect
    		(and (AtPose ?ego ?pose2)
    			 (not (AtPose ?ego ?pose))
    			 (increase (total-cost) 1))
    )
    (:action switchleft
    	:parameters (?ego ?pose1 ?pose2 ?traj ?lane1 ?lane2)
    	:precondition
    		(and (OnLane ?ego ?lane1)(AtPose ?ego ?pose1) (NeighborLeftLane ?lane2 ?lane1)
            (PoseOnLane ?pose1 ?lane1)(IsClear ?pose2)(not (Unsafe ?traj))
            (Motion ?ego ?pose1 ?pose2 ?traj)
    	:effect
    		(and (AtPose ?ego ?pose2)(OnLane ?ego ?lane2)
    			 (not (AtPose ?ego ?pose1))
    			 (not (OnLane ?ego ?lane1))
    			 (increase (total-cost) 1))
    )
    (:action switchright
    	:parameters (?ego ?pose1 ?pose2 ?traj ?lane1 ?lane2)
    	:precondition
    		(and (OnLane ?ego ?lane1)(AtPose ?ego ?pose1) (NeighborRightLane ?lane2 ?lane1)
            (PoseOnLane ?pose1 ?lane1)(IsClear ?pose2)(not (Unsafe ?traj))
            (Motion ?ego ?pose1 ?pose2 ?traj)
    	:effect
    		(and (AtPose ?ego ?pose2)(OnLane ?ego ?lane2)
    			 (not (AtPose ?ego ?pose1))
    			 (not (OnLane ?ego ?lane1))
    			 (increase (total-cost) 1))
    )
    (:derived (Unsafe ?traj)
        (exists (?obstacle ?pose) (and (Collision ?traj ?obstacle ?pose) (AtPose ?obstacle ?pose)))
    )
