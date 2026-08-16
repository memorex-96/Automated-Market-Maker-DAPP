"use client";

import Link from "next/link";
import { Address } from "@scaffold-ui/components";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { useTargetNetwork } from "~~/hooks/scaffold-eth";
import { PoolStats } from "~~/components/cpamm/PoolStats"; 
import { connected } from "process";
import { GlowingBackground } from "~~/components/background-wrappers/GlowingBackground";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const { targetNetwork } = useTargetNetwork();

  return (
    <GlowingBackground>
      <div className="flex items-center flex-col grow pt-10 px-5">
        <div className="hero bg-base-200/30 backdrop-blur-md border border-white/10 rounded-3xl p-8 max-w-5xl my-6 shadow-xl">
          <div className="hero-content flex-col lg:flex-row justify-between w-full gap-8">
            
            {/** left */}
              <div className="max-w-md">
                <h1 className="text-4xl font-bold">CPAMM Protocol</h1>
                <p className="py-4 text-base-content/80">
                  An automated market maker for decentralized token liquidity. 
                  Connect your wallet to deposit assets or execute instant swaps. 
                </p>
                <div className="flex items-center gap-2 mt-2">
                  <span className="font-medium text-sm">Connected Address:</span>
                  <Address address={connectedAddress} chain={targetNetwork} />
                </div>
              </div>

            {/** right */}
            <div className="flex flex-col items-center">
              <h2 className="text-xl font-bold mb-3 text-purple-200">Live Pool Reserves</h2>
              <PoolStats /> 
            </div>
          </div>
        </div>
        <div className="hero bg-base-200/30 backdrop-blur-md border border-white/10 rounded-3xl p-8 max-w-5xl my-6 shadow-xl">
          <div className="hero-content flex-col lg:flex-row justify-between w-full gap-8">
            {/** Liquidity pool input fields */}
          </div>  
        </div>
      </div>
    </GlowingBackground>
  );
};

export default Home;
