import { useScaffoldReadContract } from "~~/hooks/scaffold-eth";

export const PoolStats = () => {
    const { data: reserve0 } = useScaffoldReadContract({
        contractName: "CPAMM", 
        functionName: "reserve0", 
    });
    const { data: reserve1 } = useScaffoldReadContract({
        contractName: "CPAMM", 
        functionName: "reserve1", 
    }); 

    return(
        <div className="stats bg-base-200 shadow">
            <div className="stat">
                <div className="stat-title">WETH Reserve</div>
                <div className="stat-value">{reserve0 ? reserve0.toString() : "0"}</div>
            </div>
            <div className="stat">
                <div className="stat-title">USDC Reserve</div>
                <div className="stat-value">{reserve1 ? reserve1.toString() : "0"}</div>
            </div>
        </div>
    ); 
}; 